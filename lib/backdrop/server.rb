module Backdrop
  class Server
    attr_accessor :config, :logger, :pidfile
    include Daemon  

    def initialize(options = {})
      @config = {
        :log_file => "#{Dir.tmpdir}/backdrop.log",
        :pid_file => "#{Dir.tmpdir}/backdrop.pid",
        :debug => false
      }.update(options)
    
      @config.symbolize_keys!
    
      self.logger = Logger.new(config[:log_file])
      self.logger.level = config[:debug] ? Logger::DEBUG : Logger::INFO 
      self.logger.formatter = Backdrop::Formatter.new
      self.logger.info ""

      @pidfile = Backdrop::PidFile.new(config[:pid_file])
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
      daemonize(logger)

      logger.info "Became daemon with process id: #{$$}"
      begin
        pidfile.create
      rescue Exception => e
        logger.info "Exception caught while creating pidfile: #{e}"
        exit
      end

      trap("TERM") do 
        logger.info("Received TERM signal.  Exiting.") if logger
        pidfile.remove if pidfile
        exit
      end
    
      Backdrop::Runner.start
    
      # main loop run
      begin
        loop do
          Backdrop::Runner.run
        end
      rescue Object => e
        logger.error "Exception in runner: #{e.message}\n#{e.backtrace.join("\n")}"
        stop
      end
    end

    def stop
      if @pidfile.pid
        
        Backdrop::Runner.stop
        
        puts "Sending TERM signal to process #{@pidfile.pid}" if config[:debug]
        logger.info("Killing server at #{@pidfile.pid}")
        Process.kill("TERM", @pidfile.pid.to_i)
      else
        puts "Can't find pid.  Are you sure I'm running?"
      end
    end

    def restart
      stop
      sleep 5
      start
    end  
  end
end