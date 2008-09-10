#!/usr/bin/env ruby

require 'rubygems'
require 'backdrop'

module Backdrop
  class Runner
    def self.run(logger)
      logger.info "Running im my loop"
      system("echo 'c' >> /tmp/c")
    end
  end
end

