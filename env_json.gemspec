# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'env_json/version'

Gem::Specification.new do |spec|
  spec.name          = "env_json"
  spec.version       = EnvJson::VERSION
  spec.authors       = ["Vincent Hellot"]
  spec.email         = ["hellvinz@gmail.com"]

  spec.summary       = %q{Load ENV variables from a JSON file}
  spec.description   = %q{Load ENV variables from a JSON file. Usefull with ejson https://github.com/Shopify/ejson}
  spec.homepage      = "http://github.com/hellvinz/env_json"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-rcov"
  spec.add_development_dependency "yard"
end
