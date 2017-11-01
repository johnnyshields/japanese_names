# frozen_string_literal: true

module JapaneseNames
  # Provides methods to split a full Japanese name strings into surname and given name.
  class Splitter
    # Given a kanji and kana representation of a name splits into to family/given names.
    #
    # The choice to prioritize family name is arbitrary. Further analysis is needed
    # for whether given or family name should be prioritized.
    #
    # Returns Array [[kanji_fam, kanji_giv], [kana_fam, kana_giv]] if there was a match.
    # Returns nil if there was no match.
    def split(kanji, kana)
      return nil unless kanji && kana
      kanji = kanji.strip
      kana  = kana.strip

      # Short-circuit: Return last name if it can match the full string
      if kanji.size <= 3 && kana.size <= 4
        full_match = finder.find(kanji).detect { |d| d[0] == kanji && d[1] =~ /\A#{hk kana}\z/ }
        return [[kanji, nil], [kana, nil]] if full_match
      end

      # Partition kanji into candidate n-grams
      kanji_ngrams = Util::Ngram.ngram_partition(kanji)

      # Find all possible matches of all kanji n-grams in dictionary
      dict = finder.find(kanji_ngrams.flatten.uniq)

      first_lhs_match = nil
      first_rhs_match = nil
      kanji_ngrams.each do |kanji_pair|
        lhs_dict = dict.select { |d| d[0] == kanji_pair[0] }
        rhs_dict = dict.select { |d| d[0] == kanji_pair[1] }

        lhs_match = detect_lhs(lhs_dict, kanji, kana)
        rhs_match = detect_rhs(rhs_dict, kanji, kana)

        return lhs_match if lhs_match && lhs_match == rhs_match

        first_lhs_match ||= lhs_match
        first_rhs_match ||= rhs_match
      end

      # As a fallback, return single-sided match prioritizing surname match first
      first_lhs_match || first_rhs_match
    end

    private

    def detect_lhs(dict, kanji, kana)
      dict_match = dict.select { |d| match_kana_lhs(d, kana) }.sort_by { |m| m[1].size * -1 }.first
      if dict_match
        kana_match = match_kana_lhs(dict_match, kana)
        return [[dict_match[0], Util::Ngram.mask_left(kanji, dict_match[0])],
                [kana_match, Util::Ngram.mask_left(kana, kana_match)]]
      end
    end

    def detect_rhs(dict, kanji, kana)
      dict_match = dict.select { |d| match_kana_rhs(d, kana) }.sort_by { |m| m[1].size * -1 }.first
      if dict_match
        kana_match = match_kana_rhs(dict_match, kana)
        return [[Util::Ngram.mask_right(kanji, dict_match[0]), dict_match[0]],
                [Util::Ngram.mask_right(kana, kana_match), kana_match]]
      end
    end

    def match_kana_lhs(dict, kana)
      kana[/\A#{hk dict[1]}/]
    end

    def match_kana_rhs(dict, kana)
      kana[/#{hk dict[1]}\z/]
    end

    # Returns a regex string which matches both hiragana and katakana variations of a String.
    def hk(str)
      "(?:#{Moji.kata_to_hira(str)}|#{Moji.hira_to_kata(str)})"
    end

    def finder
      @finder ||= Finder.new
    end
  end
end
