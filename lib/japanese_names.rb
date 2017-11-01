# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'moji'

require 'japanese_names/version'
require 'japanese_names/enamdict'
require 'japanese_names/finder'
require 'japanese_names/splitter'
require 'japanese_names/util/kernel'
require 'japanese_names/util/ngram'
require 'japanese_names/backend/memory/store'

# Root namespace for library
module JapaneseNames
  def self.root
    File.join(File.dirname(__FILE__), '../')
  end
end
