# frozen_string_literal: true

require 'spec_helper'

RSpec.describe JapaneseNames::Util::Ngram do

  describe '#ngram_partition' do
    it { expect(described_class.ngram_partition('abcd')).to eq [%w[ab cd], %w[abc d], %w[a bcd]] }
    it { expect(described_class.ngram_partition('abcde')).to eq [%w[ab cde], %w[abc de], %w[a bcde], %w[abcd e]] }
  end

  describe '#index_partition' do
    it { expect(described_class.index_partition('abcde', 2)).to eq %w[ab cde] }
  end

  describe '#spiral_partition_indexes' do
    it { expect(described_class.spiral_partition_indexes(0)).to eq [0] }
    it { expect(described_class.spiral_partition_indexes(1)).to eq [0] }
    it { expect(described_class.spiral_partition_indexes(2)).to eq [1] }
    it { expect(described_class.spiral_partition_indexes(3)).to eq [1, 2] }
    it { expect(described_class.spiral_partition_indexes(4)).to eq [2, 3, 1] }
    it { expect(described_class.spiral_partition_indexes(5)).to eq [2, 3, 1, 4] }
    it { expect(described_class.spiral_partition_indexes(6)).to eq [3, 4, 2, 5, 1] }
    it { expect(described_class.spiral_partition_indexes(7)).to eq [3, 4, 2, 5, 1, 6] }
    it { expect(described_class.spiral_partition_indexes(8)).to eq [4, 5, 3, 6, 2, 7, 1] }
    it { expect(described_class.spiral_partition_indexes(9)).to eq [4, 5, 3, 6, 2, 7, 1, 8] }
  end

  describe '#mask_left' do
    it { expect(described_class.mask_left('abcde', 'ab')).to eq 'cde' }
  end

  describe '#mask_right' do
    it { expect(described_class.mask_right('abcde', 'de')).to eq 'abc' }
  end
end
