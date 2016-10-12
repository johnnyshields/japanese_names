$:.push File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'rspec'
require 'japanese_names'

RSpec.configure do |config|
  config.mock_with :rspec
end
