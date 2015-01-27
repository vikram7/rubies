# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubies/version'

Gem::Specification.new do |spec|
  spec.name          = "rubies"
  spec.version       = Rubies::VERSION
  spec.authors       = ["Vikram Ramakrishnan"]
  spec.email         = ["lord.ezar@gmail.com"]
  spec.summary       = %q{A Ruby gem to practice small ruby coding drills.}
  spec.description   = %q{Newcomers to programming would benefit from practicing drills regularly until basic problem solving becomes second nature. This gem is a command line tool that allows users to solve randomly generated small problems. It currently supports drills surrounding complex data structures. }
  spec.homepage      = "https://github.com/vikram7/rubies"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faker"
  spec.add_dependency "colorize"
  spec.add_dependency "awesome_print"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
