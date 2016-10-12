module JapaneseNames
module Backend
module Mongoid
  class Finder

    def load!
      store.each do |line|
        model = ::JapaneseNames::Backend::Mongoid::Row.new
        model.kanji = line[0]
        model.kana  = line[1]
        model.flags = line[2].split
        model.create!
      end
    end

    private

    def store
      ::JapaneseNames::Backend::Memory::Store.store
    end
  end
end
end
end
