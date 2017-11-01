# frozen_string_literal: true

module JapaneseNames
  module Util
    # Provides methods for parsing Japanese name strings.
    class Ngram
      class << self

        def ngram_partition(str)
          size = str.size
          spiral_partion_indexes(size).map do |i|
            index_partition(str, i)
          end
        end

        def index_partition(str, i)
          [str[0...i], str[i..-1]]
        end

        def spiral_partion_indexes(size)
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

        # irb(main):122:0> spiral_partion_indexes(5)
        # => [2, 3, 1, 4]
        # irb(main):123:0> spiral_partion_indexes(7)
        # => [3, 4, 2, 5, 1, 6]
        # irb(main):124:0> spiral_partion_indexes(6)
        # => [3, 4, 2, 5, 1]
        # irb(main):125:0> spiral_partion_indexes(1)
        # => [0]
        # irb(main):126:0> spiral_partion_indexes(2)
        # => [1]
        # irb(main):127:0> spiral_partion_indexes(1)
        # => [0]
        # irb(main):128:0> spiral_partion_indexes(0)
        # => [0]
        # irb(main):129:0> spiral_partion_indexes(2)
        # => [1]
        # irb(main):130:0> spiral_partion_indexes(3)
        # => [1, 2]
        # irb(main):131:0> spiral_partion_indexes(4)
        # => [2, 3, 1]
        # irb(main):132:0> spiral_partion_indexes(5)
        # => [2, 3, 1, 4]
        # irb(main):133:0> spiral_partion_indexes(6)
        # => [3, 4, 2, 5, 1]
        # irb(main):134:0> spiral_partion_indexes(7)
        # => [3, 4, 2, 5, 1, 6]
        # irb(main):135:0> spiral_partion_indexes(8)
        # => [4, 5, 3, 6, 2, 7, 1]
        # irb(main):136:0> spiral_partion_indexes(9)
        # => [4, 5, 3, 6, 2, 7, 1, 8]



        # # Given a String, returns an ordered array of all possible substrings.
        # #
        # # Example: ngram_right("abcd")  #=> ["abcd", "abc", "bcd", "ab", "bc", "cd", "a", "b", "c", "d"]
        # def ngram(str)
        #   (0...str.size).to_a.reverse.map { |i| (0...(str.size - i)).map { |j| str[j..(i + j)] } }.flatten.uniq
        # end
        #
        # # Given a String, returns an array of progressively smaller substrings anchored on the left side.
        # #
        # # Example: ngram_left("abcd")  #=> ["abcd", "abc", "ab", "a"]
        # def ngram_left(str)
        #   (0...str.size).to_a.reverse.map { |i| str[0..i] }
        # end
        #
        # # Given a String, returns an array of progressively smaller substrings anchored on the left side.
        # #
        # # Example: ngram_left("abcd")  #=> ["abcd", "abc", "ab", "a"]
        # def ngram_left(str)
        #   (0...str.size).to_a.reverse.map { |i| str[0..i] }
        # end
        #
        # # Given a String, returns an array of progressively smaller substrings anchored on the right side.
        # #
        # # Example: ngram_right("abcd")  #=> ["abcd", "bcd", "cd", "d"]
        # def ngram_right(str)
        #   (0...str.size).map { |i| str[i..-1] }
        # end
        #
      end
    end
  end
end
