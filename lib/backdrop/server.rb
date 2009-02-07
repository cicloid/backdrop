module Backdrop
  class Server
    attr_accessor :config, :logger, :pidfile
    include Daemon  

    def initialize(config_file = nil)
      options = YAML.load(ERB.new(File.read(config_file)).result).symbolize_keys

      @config = {
        :log_file => "#{Dir.tmpdir}/backdrop.log",
        :pid_file => "#{Dir.tmpdir}/backdrop.pid",
        :debug => false,
        :daemon_path => nil # set to path pointing to you daemon implementation
      }.update(options)
    
      validate!
    
      self.logger = Logger.new(config[:log_file])
      self.logger.level = config[:debug] ? Logger::DEBUG : Logger::INFO 
      self.logger.formatter = Backdrop::Formatter.new
      self.logger.info ""

      @pidfile = Backdrop::PidFile.new(config[:pid_file])
    end
    
    def validate!
      raise ArgumentError, "Need a main daemon implementation class, please set :daemon_path" if config[:daemon_path].blank?
    end
  
    def become_user(username = 'nobody', chroot = false)
      user = Etc::getpwnam(username) 

      Dir.chroot(user.dir) and Dir.chdir('/') if chroot

      Process::initgroups(username, user.gid) 
      Process::Sys::setegid(user.gid) 
      Process::Sys::setgid(user.gid) 
      Process::Sys::setuid(user.uid) 
    end
  
    def start
      pidfile.ensure_empty! "ERROR: It looks like I'm already running.  Not starting."
    
      logger.info "Starting server"
      logger.info "logging to #{config[:log_file]}"
      logger.info "storing PID at #{config[:pid_file]}"
      logger.info "requiring main implementation from #{config[:daemon_path]}"
      
      require config[:daemon_path]
      
      daemonize(logger)

      logger.info "Became daemon with process id: #{$$}"
      begin
        pidfile.create
      rescue Exception => e
        logger.info "Exception caught while creating pidfile: #{e}"
        exit
      end

      trap("TERM") do 
        logger.info("Received signal TERM - Shutting down") if logger
        pidfile.remove if pidfile
        exit
      end
    
      Backdrop::Runner.start(logger)
    
      # main loop run
      begin
        loop do
          Backdrop::Runner.run(logger)
        end
      rescue Object => e
        logger.error "Exception in runner: #{e.message}\n#{e.backtrace.join("\n")}"
        stop
      end
    end

    def stop
      if @pidfile.pid
        
        Backdrop::Runner.stop(logger)
        
        puts "Sending signal TERM to process #{pidfile.pid}" if config[:debug]
        logger.info("Killing server with PID #{pidfile.pid}")
        Process.kill("TERM", pidfile.pid.to_i)
        @pidfile.remove
      else
        puts "PID cannot be found. Server not running?"
      end
    end

    def restart
      stop
      sleep 5
      start
    end  
  end
end