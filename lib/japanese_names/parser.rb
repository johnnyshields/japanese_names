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
      split_surname(kanji, kana) || split_given(kanji, kana)
    end

    def split_giv(kanji, kana)
      return nil unless kanji && kana
      kanji, kana = kanji.strip, kana.strip
      dict = Finder.find(kanji: Util::Ngram.ngram_right(kanji))
      dict.sort!{|x,y| y[0].size <=> x[0].size}
      kana_match = nil
      if match = dict.detect{|m| kana_match = kana[/#{hk m[1]}$/]}
        return [[Util::Ngram.mask_right(kanji, match[0]), match[0]],[Util::Ngram.mask_right(kana, kana_match), kana_match]]
      end
    end
    alias :split_given :split_giv

    def split_sur(kanji, kana)
      return nil unless kanji && kana
      kanji, kana = kanji.strip, kana.strip
      dict = Finder.find(kanji: Util::Ngram.ngram_left(kanji))
      dict.sort!{|x,y| y[0].size <=> x[0].size}
      kana_match = nil
      if match = dict.detect{|m| kana_match = kana[/^#{hk m[1]}/]}
        return [[match[0], Util::Ngram.mask_left(kanji, match[0])],[kana_match, Util::Ngram.mask_left(kana, kana_match)]]
      end
    end
    alias :split_surname :split_sur

    # TODO: add option to strip honorific '様'
    # TODO: add option to infer sex (0 = unknown, 1 = male, 2 = female as per ISO/IEC 5218)

    private

    # Returns a regex string which matches both hiragana and katakana variations of a String.
    def hk(str)
      "(?:#{Moji.kata_to_hira(str)}|#{Moji.hira_to_kata(str)})"
    end
  end
end
