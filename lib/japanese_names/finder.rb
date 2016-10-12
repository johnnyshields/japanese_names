module JapaneseNames

  # Query interface for the
  module Finder

    class << self

      def find(opts={})
        backend.find(opts)
      end

      protected

      # Internal: Builds regex criteria for name.
      def backend
        ::JapaneseNames::Backend::Memory::Finder
      end
    end
  end
end
