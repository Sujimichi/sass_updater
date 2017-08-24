# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sass_updater/version"

Gem::Specification.new do |spec|
  spec.name          = "sass_updater"
  spec.version       = SassUpdater::VERSION
  spec.authors       = ["Sujimichi"]
  spec.email         = ["sujimichi@gmail.com"]

  spec.summary       = "convert old style sass files into current format"
  spec.description   = "processes stylesheets to convert old stlye syntax ie: ':display none' to current convention ie: 'display: none'"
  spec.homepage      = "https://github.com/Sujimichi/sass_updater"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  #spec.bindir        = "lib"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard", "~> 2.0"
  spec.add_development_dependency "guard-rspec", "~> 4.0"
  spec.add_runtime_dependency "thor", "~> 0"
end
