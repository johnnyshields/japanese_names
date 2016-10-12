require 'spec_helper'

describe JapaneseNames::StringUtil do

  describe '#ngrams' do
    it { expect(described_class.ngrams("abcd")).to eq ["abcd", "abc", "bcd", "ab", "bc", "cd", "a", "b", "c", "d"] }
  end

  describe '#ngrams_left' do
    it { expect(described_class.ngrams_left("abcd")).to eq ["abcd", "abc", "ab", "a"] }
  end

  describe '#ngrams_right' do
    it { expect(described_class.ngrams_right("abcd")).to eq ["abcd", "bcd", "cd", "d"] }
  end

  describe '#mask_left' do
    it { expect(described_class.mask_left("abcde", "ab")).to eq "cde" }
  end

  describe '#mask_right' do
    it { expect(described_class.mask_right("abcde", "de")).to eq "abc" }
  end
end
