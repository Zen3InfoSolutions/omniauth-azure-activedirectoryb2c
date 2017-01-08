lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/azure_activedirectoryb2c/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-azure-activedirectoryb2c"
  spec.version       = Omniauth::AzureActiveDirectoryB2C::VERSION
  spec.authors       = ["Microsoft Corporation"]
  spec.email         = ["nugetaad@microsoft.com"]

  spec.summary       = "OmniAuth strategy for Azure Active Directory B2C"
  spec.description   = "OmniAuth strategy for session management with Active Directory B2C"
  spec.homepage      = "https://github.com/AzureAD/omniauth-azure-activedirectory"
  spec.license       = "MIT"

  spec.files           = `git ls-files`.split("\n")
  spec.require_paths   = ['lib']

  spec.add_runtime_dependency 'jwt', '~> 1.5'
  spec.add_runtime_dependency 'omniauth', '~> 1.1'

  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rubocop', '~> 0.32'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 1.21'
end