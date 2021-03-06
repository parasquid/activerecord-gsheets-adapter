# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/gsheets/adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-gsheets-adapter"
  spec.version       = ActiveRecord::Gsheets::Adapter::VERSION
  spec.authors       = ["parasquid"]
  spec.email         = ["tristan.gomez@gmail.com"]

  spec.summary       = %q{activerecord-gsheets-adapter is an ActiceeEcord Adapter for Google Spreadsheets}
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/parasquid/activerecord-gsheets-adapter"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "rails", "4.2.4"

  spec.add_dependency "activerecord", "~> 4.2"
  spec.add_dependency "signet", "~> 0.6.1"
  spec.add_dependency "hurley", "~> 0.2"
  spec.add_dependency "nori", "~> 2.6.0"
end
