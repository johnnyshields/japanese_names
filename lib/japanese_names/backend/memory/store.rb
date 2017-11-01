# frozen_string_literal: true

module JapaneseNames
  module Backend
    module Memory
      # In-memory store of the Enamdict dictionary
      class Store
        class << self
          # Public: The memoized dictionary instance.
          def store
            @store ||= JapaneseNames::Util::Kernel.deep_freeze(
              File.open(filepath, 'r:utf-8').map { |line| line.chop.split('|') }
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
