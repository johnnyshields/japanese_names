module JapaneseNames
module Util

  # Provides methods for parsing Japanese name strings.
  class Ngram

    class << self

      # Given a String, returns an ordered array of all possible substrings.
      #
      # Example: ngram_right("abcd")  #=> ["abcd", "abc", "bcd", "ab", "bc", "cd", "a", "b", "c", "d"]
      def ngram(str)
        (0...str.size).to_a.reverse.map{|i| (0...(str.size-i)).map{|j| str[j..(i+j)]}}.flatten.uniq
      end

      # Given a String, returns an array of progressively smaller substrings anchored on the left side.
      #
      # Example: ngram_left("abcd")  #=> ["abcd", "abc", "ab", "a"]
      def ngram_left(str)
        (0...str.size).to_a.reverse.map{|i| str[0..i]}
      end

      # Given a String, returns an array of progressively smaller substrings anchored on the right side.
      #
      # Example: ngram_right("abcd")  #=> ["abcd", "bcd", "cd", "d"]
      def ngram_right(str)
        (0...str.size).map{|i| str[i..-1]}
      end

      # Masks a String from the left side and returns the remaining (right) portion of the String.
      #
      # Example: mask_left("abcde", "ab") #=> "cde"
      def mask_left(str, mask)
        str.gsub(/^#{mask}/, '')
      end

      # Masks a String from the right side and returns the remaining (left) portion of the String.
      #
      # Example:  mask_right("abcde", "de") #=> "abc"
      def mask_right(str, mask)
        str.gsub(/#{mask}$/, '')
      end
    end
  end
end
end
