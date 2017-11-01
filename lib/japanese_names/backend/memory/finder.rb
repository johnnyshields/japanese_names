# frozen_string_literal: true

module JapaneseNames
  module Backend
    module Memory
      # Provider search functionality for in-memory dictionary
      class Finder
        class << self
          # Public: Finds kanji and/or kana regex strings in the dictionary via
          # a structured query interface.
          #
          # opts - The Hash options used to match the dictionary (default: {}):
          #        kanji: Regex to match kanji name (optional)
          #        kana:  Regex to match kana name (optional)
          #        flags: Flag or Array of flags to filter the match (optional)
          #
          # Returns the dict entries as an Array of Arrays [[kanji, kana, flags], ...]
          def find(opts = {})
            return [] unless opts[:kanji] || opts[:kana]
            kanji = name_regex  opts.delete(:kanji)
            kana  = name_regex  opts.delete(:kana)
            flags = flags_regex opts.delete(:flags)
            store.select do |row|
              (!kanji || row[0] =~ kanji) && (!kana || row[1] =~ kana) && (!flags || row[2] =~ flags)
            end
          end

          private

          def store
            ::JapaneseNames::Backend::Memory::Store.store
          end

          # Internal: Builds regex criteria for name.
          def name_regex(name)
            case name
            when String, Symbol then /\A#{name}\z/
            when Array then /\A(?:#{name.join('|')})\z/
            end
          end

          # Internal: Builds regex criteria for flags.
          def flags_regex(flags)
            case flags
            when ::JapaneseNames::Enamdict::NAME_ANY then nil
            when String, Symbol then /[#{flags}]/
            when Array then /[#{flags.join}]/
            end
          end
        end
      end
    end
  end
end
