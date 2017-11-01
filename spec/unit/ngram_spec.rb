# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JapaneseNames::Util::Ngram do
  describe '#ngram' do
    it { expect(described_class.ngram("abcd")).to eq %w[abcd abc bcd ab bc cd a b c d] }
  end

  describe '#ngram_left' do
    it { expect(described_class.ngram_left("abcd")).to eq %w[abcd abc ab a] }
  end

  describe '#ngram_right' do
    it { expect(described_class.ngram_right("abcd")).to eq %w[abcd bcd cd d] }
  end

  describe '#mask_left' do
    it { expect(described_class.mask_left("abcde", "ab")).to eq "cde" }
  end

  describe '#mask_right' do
    it { expect(described_class.mask_right("abcde", "de")).to eq "abc" }
  end
end
