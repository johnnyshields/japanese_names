# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'rspec'
require 'yaml'
require 'japanese_names'

RSpec.configure do |config|
  config.mock_with :rspec

  config.disable_monkey_patching!
end
