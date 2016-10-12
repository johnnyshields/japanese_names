module JapaneseNames

  # Query interface for ENAMDICT
  class Finder

    # Hash opts
    # - kanji: String kanji to match
    # - kana:  String kana to match
    # - kanji: Array<Symbol> ENAMDICT flags to match
    def find(opts={})
      backend.find(opts)
    end

    private

    # Internal: Builds regex criteria for name.
    def backend
      ::JapaneseNames::Backend::Memory::Finder
    end
  end
end
