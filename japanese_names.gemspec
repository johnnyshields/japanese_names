$:.push File.expand_path('../lib', __FILE__)
require 'japanese_names/version'

Gem::Specification.new do |s|
  s.name        = 'japanese_names'
  s.version     = JapaneseNames::VERSION
  s.authors     = ['Johnny Shields']
  s.homepage    = 'https://github.com/johnnyshields/japanese_names'
  s.license     = 'MIT'
  s.summary     = 'Tools for parsing japanese names'
  s.description = 'Japanese name parser based on ENAMDICT'
  s.email       = 'johnny.shields@gmail.com'

  s.files         = Dir.glob('{lib,bin}/**/*') + %w(LICENSE README.md)
  s.test_files    = Dir.glob('{perf,spec}/**/*')
  s.require_paths = ['lib']

  s.post_install_message = File.read('UPGRADING') if File.exists?('UPGRADING')

  s.add_dependency 'moji', '>= 1.6'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '>= 3.0.0'
  s.add_development_dependency 'gem-release'
end
