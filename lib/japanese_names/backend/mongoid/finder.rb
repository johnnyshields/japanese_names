module JapaneseNames
module Backend
module Mongoid
  class Finder

    def find(opts)
      return [] unless opts[:kanji] || opts[:kana]
      kanji = opts.delete(:kanji)
      kana  = opts.delete(:kana)
      flags = opts.delete(:flags)

      crit = JapaneseNames::Backend::Mongoid::Row
      crit = name_criteria(crit, :kanji, kanji)
      crit = name_criteria(crit, :kana, kana)
      crit = flags_criteria(crit, flags)
      crit
    end

    private

    def name_criteria(crit, field, name)
      case name
        when String, Symbol then crit.where(field => name)
        when Array then crit.any_in(field => name)
        else crit
      end
    end

    def flags_criteria(crit, flags)
      case flags
        when ::JapaneseNames::Enamdict::NAME_ANY then crit
        when String, Symbol then crit.any_in(flags: flags.to_s.split)
        when Array then crit.any_in(flags: flags)
        else crit
      end
    end
  end
end
end
end
