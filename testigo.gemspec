# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "testigo/version"

Gem::Specification.new do |s|
  s.name             = "testigo"
  s.version          = Testigo::VERSION
  s.authors          = ["Gustavo Barron"]
  s.email            = ["cicloid@42fu.com"]
  s.homepage         = %q{http://github.com/cicloid/testigo}
  s.summary          = %q{Simple Ushahidi library via API Smith}
  s.licenses         = [%q{MIT}]
  s.require_paths    = [%q{lib}]
  s.rubygems_version = %q{1.8.10}
  s.description      = %q{Ushahidi API Gem}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "vcr"
  s.add_runtime_dependency "api_smith"
end
