require_relative 'lib/param_cryptable/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-param_cryptable"
  spec.version       = ParamCryptable::VERSION
  spec.authors       = ["Pelle ten Cate"]
  spec.email         = ["hi@pelle.codes"]

  spec.summary       = %q{Encrypted URL parameters for Rails}
  spec.description   = %q{Simple encryption for URL parameters in rails, meant as a drop-in obfuscation layer for IDs}
  spec.homepage      = "https://pelle.codes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pelletencate/rails-param_cryptable"
  spec.metadata["changelog_uri"] = "https://github.com/pelletencate/rails-param_cryptable/CHANGELOG.md"

  spec.add_dependency 'rails', '>= 5.2.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end