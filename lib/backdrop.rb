$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Backdrop
end

%w( rubygems thread etc active_support yaml erb fileutils logger resolv-replace daemon tmpdir).each do |lib|
  require lib
end

require "backdrop/version"
require "backdrop/pid_file"
require "backdrop/formatter"
require "backdrop/runner"
require "backdrop/server"