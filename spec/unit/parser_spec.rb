require 'spec_helper'

describe JapaneseNames::Parser do

  subject { JapaneseNames::Parser.new }

  describe '#split' do

    [['上原','望','ウエハラ', 'ノゾミ'],
     ['樋口','知美','ヒグチ', 'ともみ'],
     ['堺','雅美','さかい', 'マサミ'],
     ['中村','幸子','ナカムラ', 'サチコ'],
     ['秋保','郁子','アキホ', 'いくこ'],
     ['光野','亜佐子','ミツノ', 'アサコ'],
     ['熊澤','貴子','クマザワ', 'タカコ']].each do |kanji_fam, kanji_giv, kana_fam, kana_giv|
      it "should parse #{kanji_fam+kanji_giv} #{kana_fam+kana_giv}" do
        result = subject.split(kanji_fam+kanji_giv, kana_fam+kana_giv)
        result.should eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
      end

      it "should parse #{kanji_fam+kanji_giv} #{kana_fam+kana_giv} by given name" do
        result = subject.split_giv(kanji_fam+kanji_giv, kana_fam+kana_giv)
        result.should eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
      end

      it "should parse #{kanji_fam+kanji_giv} #{kana_fam+kana_giv} by family name" do
        result = subject.split_fam(kanji_fam+kanji_giv, kana_fam+kana_giv)
        result.should eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
      end
    end

    [['XXX','XXX','XXX','XXX']].each do |kanji_fam, kanji_giv, kana_fam, kana_giv|
      it "should return nil for invalid name #{kanji_fam+kanji_giv} #{kana_fam+kana_giv}" do
        result = subject.split(kanji_fam+kanji_giv, kana_fam+kana_giv)
        result.should be_nil
      end
    end

    it 'should strip leading/trailing whitespace' do
      subject.split(' 上原望 ', ' ウエハラノゾミ ').should eq [['上原','望'],['ウエハラ','ノゾミ']]
      subject.split_giv(' 上原望 ', ' ウエハラノゾミ ').should eq [['上原','望'],['ウエハラ','ノゾミ']]
      subject.split_fam(' 上原望 ', ' ウエハラノゾミ ').should eq [['上原','望'],['ウエハラ','ノゾミ']]
    end

    it 'should return nil for nil input' do
      subject.split(nil, 'ウエハラノゾミ').should be_nil
      subject.split('上原望', nil).should be_nil
    end
  end
end
