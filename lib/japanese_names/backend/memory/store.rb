module JapaneseNames
module Backend
module Memory
  class Store

    class << self

      # Public: The memoized dictionary instance.
      def store
        @store ||= File.open(filepath, 'r:utf-8').map do |line|
          line.chop.split('|').map(&:freeze).freeze
        end.freeze
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
