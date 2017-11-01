# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JapaneseNames::Finder do
  subject { described_class.new }

  describe '#find' do
    it 'should match kanji only' do
      result = subject.find(kanji: '外世子')
      expect(result).to eq [%w[外世子 とよこ f]]
    end

    it 'should match kana only' do
      result = subject.find(kana: 'ならしま')
      expect(result).to eq [%w[樽島 ならしま u],
                        %w[奈良島 ならしま s],
                        %w[楢島 ならしま s],
                        %w[楢嶋 ならしま s]]
    end

    it 'should match both kanji and kana only' do
      result = subject.find(kanji: '楢二郎', kana: 'ならじろう')
      expect(result).to eq [%w[楢二郎 ならじろう m]]
    end

    it 'should match flags as String' do
      result = subject.find(kana: 'ならしま', flags: 's')
      expect(result).to eq [%w[奈良島 ならしま s],
                        %w[楢島 ならしま s],
                        %w[楢嶋 ならしま s]]
    end

    it 'should match flags as Array' do
      result = subject.find(kana: 'ならしま', flags: %w[u g])
      expect(result).to eq [%w[樽島 ならしま u]]
    end
  end
end
