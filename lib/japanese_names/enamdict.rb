module JapaneseNames

  # Query interface for the ENAMDICT file (http://www.csse.monash.edu.au/~jwb/enamdict_doc.html)
  module Enamdict

    # s - surname (138,500)
    # p - place-name (99,500)
    # u - person name, either given or surname, as-yet unclassified (139,000)
    # g - given name, as-yet not classified by sex (64,600)
    # f - female given name (106,300)
    # m - male given name (14,500)
    NAME_FAM = %w(s p u).freeze
    NAME_GIV = %w(u g f m).freeze
    NAME_ANY = (NAME_FAM | NAME_GIV).freeze

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
          when String then /\A#{name}\z/
          when Array  then /\A(?:#{name.join('|')})\z/
          else nil
        end
      end

      # Internal: Builds regex criteria for flags.
      def flags_regex(flags)
        case flags
          when NAME_ANY then nil
          when Array then /[#{flags.join}]/
          when String then /[#{flags}]/
          else nil
        end
      end
    end
  end
end
