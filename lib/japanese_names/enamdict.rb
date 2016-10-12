module JapaneseNames

  # Query interface for the ENAMDICT file (http://www.csse.monash.edu.au/~jwb/enamdict_doc.html)
  module Enamdict

    # s - surname (138,500)
    # p - place-name (99,500)
    # u - person name, either given or surname, as-yet unclassified (139,000)
    # g - given name, as-yet not classified by sex (64,600)
    # f - female given name (106,300)
    # m - male given name (14,500)
    NAME_FAM = %w(s p u)
    NAME_GIV = %w(u g f m)
    NAME_ANY = NAME_FAM | NAME_GIV

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
        regex = /^#{kanji}\|#{kana}\|#{flags}$/

        match{|line| line[regex]}
      end

      # Public: Matches entries in the enamdict based on a block which should
      # evaluate true or false (typically a regex).
      #
      # Returns the dict entries as an Array of Arrays [[kanji, kana, flags], ...]
      def match(&block)
        sel = []
        each_line do |line|
          if block.call(line)
            sel << unpack_line(line)
          end
        end
        sel
      end

      protected

      # Internal: Returns the filepath to the enamdict.min file.
      def filepath
        File.join(JapaneseNames.root, 'bin/enamdict.min')
      end

      # Internal: The memoized dictionary instance.
      def dict
        @dict ||= begin
          ary = []
          File.open(self.filepath, 'r:utf-8') do |f|
            while(line = f.gets) != nil
              ary << line[0..-2] # omit trailing newline char
            end
          end
          ary
        end.freeze
      end

      # Internal: Calls the given block for each line in the dict.
      def each_line(&block)
        dict.each{|line| block.call(line) }
      end

      # Internal: Formats a line as a 3-tuple Array [kanji, kana, flags]
      def unpack_line(line)
        line.split('|')
      end

      # Internal: Builds regex criteria for name.
      def name_regex(name)
        case name
          when String then name
          when Array  then "(?:#{name.join('|')})"
          else '.+?'
        end
      end

      # Internal: Builds regex criteria for flags.
      def flags_regex(flags)
        if !flags || flags == NAME_ANY
          '.+?'
        elsif flags.is_a?(Array)
          ".*?[#{flags.join}].*?"
        else
          flags
        end
      end
    end
  end
end
