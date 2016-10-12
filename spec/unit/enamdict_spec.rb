require 'spec_helper'

describe JapaneseNames::Enamdict do

  subject { JapaneseNames::Enamdict }

  describe '#match' do

    it 'should select only lines which match criteria' do
      result = subject.match{|line| line =~ /^.+?\|あわのはら\|.+?$/}
      result.should eq [["粟野原", "あわのはら", "s"]]
    end

    it 'should select multiple lines' do
      result = subject.match{|line| line =~ /^.+?\|はしの\|.+?$/}
      result.should eq [["橋之", "はしの", "p"],
                        ["橋埜", "はしの", "s"],
                        ["橋野", "はしの", "s"],
                        ["端野", "はしの", "s"],
                        ["箸野", "はしの", "s"]]
    end
  end

  describe '#find' do

    it 'should match kanji only' do
      result = subject.find(kanji: '外世子')
      result.should eq [["外世子", "とよこ", "f"]]
    end

    it 'should match kana only' do
      result = subject.find(kana: 'ならしま')
      result.should eq [["樽島", "ならしま", "u"],
                        ["奈良島", "ならしま", "s"],
                        ["楢島", "ならしま", "s"],
                        ["楢嶋", "ならしま", "s"]]
    end

    it 'should match both kanji and kana only' do
      result = subject.find(kanji: '楢二郎', kana: 'ならじろう')
      result.should eq [["楢二郎", "ならじろう", "m"]]
    end

    it 'should match flags as String' do
      result = subject.find(kana: 'ならしま', flags: 's')
      result.should eq [["奈良島", "ならしま", "s"],
                        ["楢島", "ならしま", "s"],
                        ["楢嶋", "ならしま", "s"]]
    end

    it 'should match flags as Array' do
      result = subject.find(kana: 'ならしま', flags: ['u','g'])
      result.should eq [["樽島", "ならしま", "u"]]
    end
  end
end
