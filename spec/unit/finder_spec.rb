# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JapaneseNames::Finder do
  subject { described_class.new }

  describe '#find' do
    it 'should match kanji only' do
      result = subject.find('外世子')
      expect(result).to eq [%w[外世子 とよこ f]]
    end
  end
end
