module JapaneseNames

  # Query interface for the ENAMDICT file (http://www.csse.monash.edu.au/~jwb/enamdict_doc.html)
  module Enamdict
    NAME_PLACE        = %i(p).freeze # place-name (99,500)
    NAME_PERSON       = %i(u).freeze # person name, either given or surname, as-yet unclassified (139,000)
    NAME_SURNAME      = %i(s).freeze # surname (138,500)
    NAME_GIVEN_MALE   = %i(m).freeze # male given name (14,500)
    NAME_GIVEN_FEMALE = %i(f).freeze # female given name (106,300)
    NAME_GIVEN_OTHER  = %i(g).freeze # given name, as-yet not classified by sex (64,600)
    NAME_SURNAME_ANY = (NAME_PLACE | NAME_PERSON | NAME_SURNAME).freeze
    NAME_GIVEN_ANY   = (NAME_PERSON | NAME_GIVEN_MALE| NAME_GIVEN_FEMALE | NAME_GIVEN_OTHER).freeze
    NAME_ANY = (NAME_SURNAME_ANY | NAME_GIVEN_ANY).freeze

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
      def find(opts={})
        return [] unless opts[:kanji] || opts[:kana]

        kanji = name_regex opts.delete(:kanji)
        kana  = name_regex opts.delete(:kana)
        flags = flags_regex opts.delete(:flags)

        dict.select do |row|
          (!kanji || row[0] =~ kanji) && (!kana || row[1] =~ kana) && (!flags || row[2] =~ flags)
        end
      end

      protected

      # Internal: Returns the filepath to the enamdict.min file.
      def filepath
        File.join(JapaneseNames.root, 'bin/enamdict.min')
      end

      # Internal: The memoized dictionary instance.
      def dict
        @dict ||= File.open(self.filepath, 'r:utf-8').map do |line|
          line.chop.split('|').map(&:freeze).freeze
        end.freeze
      end

      # Internal: Builds regex criteria for name.
      def name_regex(name)
        case name
          when String, Symbol then /\A#{name}\z/
          when Array then /\A(?:#{name.join('|')})\z/
          else nil
        end
      end

      # Internal: Builds regex criteria for flags.
      def flags_regex(flags)
        case flags
          when NAME_ANY then nil
          when String, Symbol then /[#{flags}]/
          when Array then /[#{flags.join}]/
          else nil
        end
      end
    end
  end
end
