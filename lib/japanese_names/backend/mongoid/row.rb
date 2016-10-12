module JapaneseNames
module Backend
module Mongoid
  class Row
    store_in collection: 'japanese_names'

    field :kanji, type: String
    field :kana,  type: String
    field :flags, type: Array, default: []

    index flags: 1, kanji: 1, kana:  1
    index flags: 1, kana:  1
    index kanji: 1, kana:  1
    index kana:  1
  end
end
end
end
