= backdrop

* FIX (url)

== DESCRIPTION:

 	 A Ruby daemon library that makes writing background daemons easy
 	 
== FEATURES/PROBLEMS:

  Backdrop allows you to easily create Ruby background daemons. It utilizes the daemon gem to go
  into the background and has some additional management utilities that allow you to control the
  running backdrop.

== SYNOPSIS:

  $ backdrop-daemon start config.yml
  
  $ backdrop-daemon stop config.yml
  
  $ backdrop-daemon restart config.yml
  
  
  Where config.yml is:
  
  ---
  daemon_path: /path/to/my/daemon.rb
  log_file: /path/to/mylog
  pid_file: /path/to/store.pid
  debug: false
  
  The `daemon_path` config parameter refers to your Ruby library that will be required by backdrop.
  This file needs to implement the actual processing task and can react to start/stop.
  
  Example:
  
  module Backdrop
    class Runner
      def self.run(logger)
        logger.info "Running im my loop"
        # .. doing the background operation once
        # will be called in a loop
      end
      
      def self.start(logger)
        # optional - react to starting the daemon
        # e.g. do setup
      end
      
      def self.run(logger)
        # optional - react to stopping the daemon
        # e.g. do resource teardown
      end
    end
  end

== REQUIREMENTS:

* ActiveSupport

== INSTALL:

* sudo gem install backdrop

* Create an Backdrop::Runner implementation

* Create matching config.yml

== LICENSE:

(The MIT License)

Copyright (c) 2008 Jonathan Weiss, based on work taken
from Based on Highrise to LDAP Gateway http://svn.thoughtbot.com/highrise-ldap-proxy/

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.