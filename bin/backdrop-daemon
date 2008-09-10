#!/usr/bin/env ruby

require 'rubygems'
require 'backdrop'

case ARGV[0]
  when "start":   Backdrop::Server.new(ARGV[1]).start
  when "stop":    Backdrop::Server.new(ARGV[1]).stop
  when "restart": Backdrop::Server.new(ARGV[1]).restart
  else puts "Usage: #{File.basename(__FILE__)} {start|stop|restart} [config file]"
end