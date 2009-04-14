# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{backdrop}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gustavo Barr\303\263n"]
  s.date = %q{2009-04-14}
  s.default_executable = %q{backdrop-daemon}
  s.description = %q{TODO}
  s.email = %q{gustavo@foobarra.com}
  s.executables = ["backdrop-daemon"]
  s.extra_rdoc_files = [
    "README.txt"
  ]
  s.files = [
    "History.txt",
    "License.txt",
    "Manifest.txt",
    "PostInstall.txt",
    "README.txt",
    "Rakefile",
    "VERSION.yml",
    "bin/backdrop-daemon",
    "lib/backdrop.rb",
    "lib/backdrop/formatter.rb",
    "lib/backdrop/pid_file.rb",
    "lib/backdrop/runner.rb",
    "lib/backdrop/server.rb",
    "lib/backdrop/version.rb",
    "lib/daemon.rb",
    "test/test.yml",
    "test/test_backdrop.rb",
    "test/test_helper.rb",
    "test/test_impl.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/cicloid/backdrop}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/test_backdrop.rb",
    "test/test_helper.rb",
    "test/test_impl.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
