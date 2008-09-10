require File.dirname(__FILE__) + '/test_helper.rb'

class TestBackdrop < Test::Unit::TestCase

  def setup
    @options = {
      :pid_file => "/tmp/test.pid",
      :log_file => '/tmp/test.log',
      :debug => true
    }
  end
  
  def test_calling_runner
    Daemon.expects(:daemonize).returns(true)
    Backdrop::Runner.expects(:run).raises(RuntimeError)
    Backdrop::Runner.expects(:start).returns(nil)
    Backdrop::Runner.expects(:stop).returns(nil)
    
    server = Backdrop::Server.new(@options)
    server.pidfile.expects(:ensure_empty!).returns(true)
    server.start
  end
  
end
