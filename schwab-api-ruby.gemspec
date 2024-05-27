# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schwab/version'

Gem::Specification.new do |spec|
  spec.name          = "schwab-api-ruby"
  spec.version       = Schwab::VERSION
  spec.authors       = ["Winston Kotzan"]
  spec.email         = ["wak@wakproductions.com"]
  spec.summary       = %q{This is a simple gem for connecting to the Schwab OAuth API}
  spec.description   = "This is a gem for connecting to the OAuth/JSON-based Schwab API. See "
      "https://beta-developer.schwab.com/ for the official documentation and to create your developer account."
  spec.homepage      = "https://github.com/wakproductions/schwab-api-ruby"
  spec.license       = "MIT"

  spec.files         = [`git ls-files`.split($/)] + Dir["lib/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", ">= 2.0"
  spec.add_dependency "rake"
  spec.add_dependency "httparty", ">= 0.20"

  spec.add_development_dependency "rspec", ">= 3.2"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
end
