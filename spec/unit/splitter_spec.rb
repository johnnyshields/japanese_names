# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JapaneseNames::Splitter do
  subject { described_class.new }

  describe '#split' do
    [%w[上原 望 ウエハラ ノゾミ],
     %w[樋口 知美 ヒグチ ともみ],
     %w[堺 雅美 さかい マサミ],
     %w[中村 幸子 ナカムラ サチコ],
     %w[秋保 郁子 アキホ いくこ],
     %w[光野 亜佐子 ミツノ アサコ],
     %w[熊澤 貴子 クマザワ タカコ]].each do |kanji_fam, kanji_giv, kana_fam, kana_giv|
      it "should parse #{kanji_fam + kanji_giv} #{kana_fam + kana_giv}" do
        result = subject.split(kanji_fam + kanji_giv, kana_fam + kana_giv)
        expect(result).to eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
      end

      it "should parse #{kanji_fam + kanji_giv} #{kana_fam + kana_giv} by given name" do
        result = subject.split_giv(kanji_fam + kanji_giv, kana_fam + kana_giv)
        expect(result).to eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
      end

      it "should parse #{kanji_fam + kanji_giv} #{kana_fam + kana_giv} by family name" do
        result = subject.split_sur(kanji_fam + kanji_giv, kana_fam + kana_giv)
        expect(result).to eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
      end
    end

    [%w[XXX XXX XXX XXX]].each do |kanji_fam, kanji_giv, kana_fam, kana_giv|
      it "should return nil for invalid name #{kanji_fam + kanji_giv} #{kana_fam + kana_giv}" do
        result = subject.split(kanji_fam + kanji_giv, kana_fam + kana_giv)
        expect(result).to eq nil
      end
    end

    it 'should strip leading/trailing whitespace' do
      expect(subject.split(' 上原望 ', ' ウエハラノゾミ ')).to eq [%w[上原 望], %w[ウエハラ ノゾミ]]
      expect(subject.split_giv(' 上原望 ', ' ウエハラノゾミ ')).to eq [%w[上原 望], %w[ウエハラ ノゾミ]]
      expect(subject.split_sur(' 上原望 ', ' ウエハラノゾミ ')).to eq [%w[上原 望], %w[ウエハラ ノゾミ]]
    end

    it 'should return nil for nil input' do
      expect(subject.split(nil, 'ウエハラノゾミ')).to eq nil
      expect(subject.split('上原望', nil)).to eq nil
    end
  end
end
