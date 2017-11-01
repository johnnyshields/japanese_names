# frozen_string_literal: true

module JapaneseNames
  module Backend
    module Memory
      # In-memory store of the Enamdict dictionary
      class Store
        class << self
          # Public: Finds kanji and/or kana regex strings in the dictionary via
          # a structured query interface.
          #
          # kanji - (String, Array) Value or array of values of the kanji name to match.
          #
          # Returns the dict entries as an Array of Arrays [[kanji, kana, flags], ...]
          def find(kanji)
            kanji = Array(kanji)
            store.values_at(*kanji).reject(&:nil?).inject(&:+) || []
          end

          # Public: The memoized dictionary instance.
          def store
            @store ||= JapaneseNames::Util::Kernel.deep_freeze(
              File.open(filepath, 'r:utf-8').each_with_object({}) do |line, hash|
                ary = line.chop.split('|')
                hash[ary[0]] ||= []
                hash[ary[0]] << ary
              end
            )
          end

          private

          # Internal: Returns the filepath to the enamdict.min file.
          def filepath
            File.join(JapaneseNames.root, 'bin/enamdict.min')
          end
        end
      end
    end
  end
end
