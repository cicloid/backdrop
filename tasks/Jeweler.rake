begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "backdrop"
    gemspec.summary = "TODO"
    gemspec.email = "gustavo@foobarra.com"
    gemspec.homepage = "http://github.com/cicloid/backdrop"
    gemspec.description = "TODO"
    gemspec.authors = ["Gustavo Barrón"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end