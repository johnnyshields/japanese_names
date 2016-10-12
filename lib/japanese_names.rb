$:.unshift File.dirname(__FILE__)

require 'moji'

require 'japanese_names/version'
require 'japanese_names/enamdict'
require 'japanese_names/parser'

module JapaneseNames
  def self.root
    File.join(File.dirname(__FILE__), '../')
  end
end
