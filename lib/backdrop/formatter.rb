module Backdrop
  class Formatter < Logger::Formatter
    def call(severity, timestamp, progname, msg)
      "#{timestamp.strftime("%H:%M:%S")}: #{severity} - #{msg}\n"
    end
  end
end