#!/bin/env ruby
# encoding: utf-8

module JapaneseNames

  # Provides methods for parsing Japanese name strings.
  class Parser

    # Given a kanji and kana representation of a name splits into to family/given names.
    #
    # The choice to prioritize family name is arbitrary. Further analysis is needed
    # for whether given or family name should be prioritized.
    #
    # Returns Array [[kanji_fam, kanji_giv], [kana_fam, kana_giv]] if there was a match.
    # Returns nil if there was no match.
    def split(kanji, kana)
      split_fam(kanji, kana) || split_giv(kanji, kana)
    end

    def split_giv(kanji, kana)
      dict = Enamdict.match(kanji: window_right(kanji))
      dict.sort!{|x,y| y[0].size <=> x[0].size}
      kana_match = nil
      if match = dict.detect{|m| kana_match = kana[/#{hk m[1]}$/]}
        return [[mask_right(kanji, match[0]), match[0]],[mask_right(kana, kana_match), kana_match]]
      end
    end

    def split_fam(kanji, kana)
      dict = Enamdict.match(kanji: window_left(kanji))
      dict.sort!{|x,y| y[0].size <=> x[0].size}
      kana_match = nil
      if match = dict.detect{|m| kana_match = kana[/^#{hk m[1]}/]}
        return [[match[0], mask_left(kanji, match[0])],[kana_match, mask_left(kana, kana_match)]]
      end
    end

    # TODO: add option to strip honorific '様'
    # TODO: add option to infer sex (0 = unknown, 1 = male, 2 = female as per ISO/IEC 5218)

    protected

    # Returns a regex string which matches both hiragana and katakana variations of a String.
    def hk(str)
      "(?:#{Moji.kata_to_hira(str)}|#{Moji.hira_to_kata(str)})"
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

    # Given a String, returns an array of progressively smaller substrings anchored on the left side.
    #
    # Example: window_left("abcde") #=>  ["abcd", "abc", "ab", "a"]
    def window_left(str)
      (0..str.size-2).to_a.reverse.map{|i| str[0..i]}
    end

    # Given a String, returns an array of progressively smaller substrings anchored on the right side.
    #
    # Example: window_right("abcde") #=>  ["bcde", "cde", "de", "e"]
    def window_right(str)
      (1..str.size-1).map{|i| str[i..-1]}
    end
  end
end
