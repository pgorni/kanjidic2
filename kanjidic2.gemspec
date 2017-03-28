# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kanjidic2/version'

Gem::Specification.new do |spec|
  spec.name          = "kanjidic2"
  spec.version       = Kanjidic2::VERSION
  spec.authors       = ["Piotr Górni"]
  spec.email         = ["pgorni@teknik.io"]

  spec.summary       = %q{A KANJIDIC2 toolkit for Ruby}
  spec.description   = %q{A simple KANJIDIC2 toolkit for Ruby, based on nokogiri.}
  spec.homepage      = "https://rubygems.org/gems/kanjidic2"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "nokogiri", "~> 1.7"
end
