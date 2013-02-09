# -*- encoding: utf-8 -*-
require File.expand_path("../lib/radix62/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "radix62"
  s.version     = Radix62::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matias Korhonen"]
  s.email       = ["matias@kiskolabs.com"]
  s.homepage    = "http://github.com/k33l0r/radix62"
  s.summary     = "Convert integers to base 62 strings and back."
  s.description = "Convert base 10 integers to base 62 strings (or base 62 strings to base 10 integers)."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "radix62"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.12"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
