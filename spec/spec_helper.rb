#!/bin/env ruby
# encoding: utf-8

$:.push File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'japanese_names'

RSpec.configure do |config|
  config.mock_with :rspec
end
