# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/bitbucket_cloud/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-bitbucket_cloud'
  spec.version       = Fastlane::BitbucketCloud::VERSION
  spec.author        = 'Luca Tagliabue'
  spec.email         = 'lu.tagliabue@reply.it'

  spec.summary       = 'Wrapper of Bitbucket cloud rest apis'
  spec.homepage      = 'https://github.com/lukluca/fastlane-plugin-bitbucket-cloud'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*'] + %w[README.md LICENSE]
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.6'
end
