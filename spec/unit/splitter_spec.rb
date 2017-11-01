# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JapaneseNames::Splitter do
  subject { described_class.new }

  describe '#split' do
    config = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    skip_list = config[:skip]

    config[:last_names].each do |last_name|
      config[:first_names].each do |first_name|
        kanji_fam, kana_fam = last_name.split(' ')
        kanji_giv, kana_giv = first_name.split(' ')

        next if skip_list.index("#{kanji_fam} #{kanji_giv}")

        it "should parse #{kanji_fam + kanji_giv} #{kana_fam + kana_giv}" do
          result = subject.split(kanji_fam + kanji_giv, kana_fam + kana_giv)
          expect(result).to eq [[kanji_fam, kanji_giv], [kana_fam, kana_giv]]
        end
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
    end

    it 'should return nil for nil input' do
      expect(subject.split(nil, 'ウエハラノゾミ')).to eq nil
      expect(subject.split('上原望', nil)).to eq nil
    end
  end
end
