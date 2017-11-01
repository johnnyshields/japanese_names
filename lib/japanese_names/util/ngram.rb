# frozen_string_literal: true

module JapaneseNames
  module Util
    # Provides methods for parsing Japanese name strings.
    class Ngram
      class << self

        # Generates middle-out partition n-grams for a string
        def ngram_partition(str)
          size = str.size
          spiral_partition_indexes(size).map do |i|
            index_partition(str, i)
          end
        end

        # Partitions a string based on an index
        def index_partition(str, i)
          [str[0...i], str[i..-1]]
        end

        # Lists middle-out partition points for a given string length
        def spiral_partition_indexes(size)
          ary = []
          last = size / 2
          ary << last
          (size - 2).times do |i|
            last = last + (i+1)*(-1)**i
            ary << last
          end
          ary
        end

        # Masks a String from the left side and returns the remaining (right) portion of the String.
        #
        # Example: mask_left("abcde", "ab") #=> "cde"
        def mask_left(str, mask)
          str.gsub(/\A#{mask}/, '')
        end

        # Masks a String from the right side and returns the remaining (left) portion of the String.
        #
        # Example:  mask_right("abcde", "de") #=> "abc"
        def mask_right(str, mask)
          str.gsub(/#{mask}\z/, '')
        end
      end
    end
  end
end
