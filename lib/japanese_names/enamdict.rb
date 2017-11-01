# frozen_string_literal: true

module JapaneseNames
  # Enumerated flags for the ENAMDICT file (http://www.csse.monash.edu.au/~jwb/enamdict_doc.html)
  module Enamdict
    NAME_PLACE        = %i[p].freeze # place-name (99,500)
    NAME_PERSON       = %i[u].freeze # person name, either given or surname, as-yet unclassified (139,000)
    NAME_SURNAME      = %i[s].freeze # surname (138,500)
    NAME_GIVEN_MALE   = %i[m].freeze # male given name (14,500)
    NAME_GIVEN_FEMALE = %i[f].freeze # female given name (106,300)
    NAME_GIVEN_OTHER  = %i[g].freeze # given name, as-yet not classified by sex (64,600)
    NAME_SURNAME_ANY = (NAME_PLACE | NAME_PERSON | NAME_SURNAME).freeze
    NAME_GIVEN_ANY   = (NAME_PERSON | NAME_GIVEN_MALE | NAME_GIVEN_FEMALE | NAME_GIVEN_OTHER).freeze
    NAME_ANY = (NAME_SURNAME_ANY | NAME_GIVEN_ANY).freeze
  end
end
