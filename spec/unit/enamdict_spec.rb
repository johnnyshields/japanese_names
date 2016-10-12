require 'spec_helper'

describe JapaneseNames::Enamdict do

  subject { JapaneseNames::Enamdict }

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
