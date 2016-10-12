$:.unshift File.dirname(__FILE__)

require 'moji'

require 'japanese_names/version'
require 'japanese_names/enamdict'
require 'japanese_names/finder'
require 'japanese_names/parser'
require 'japanese_names/util/ngram'
require 'japanese_names/backend/memory/store'
require 'japanese_names/backend/memory/finder'

module JapaneseNames
  def self.root
    File.join(File.dirname(__FILE__), '../')
  end
end
