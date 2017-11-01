# frozen_string_literal: true

module JapaneseNames
  module Util
    # Provides extensions to Ruby kernel.
    class Kernel
      class << self
        # Recursively freezes an object
        def deep_freeze(object)
          case object
          when Hash
            object.each_value { |v| deep_freeze(v) }
            object.freeze
          when Array
            object.each { |j| deep_freeze(j) }
            object.freeze
          when String
            object.freeze
          end
        end
      end
    end
  end
end
