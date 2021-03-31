# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength

# spec../enumerables

require_relative '../enumerables'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }
  let(:range) { (1..10) }
  let(:hash) { {} }

  describe '#my_each' do
    it 'if no block is given it returns an enumerator ' do
      expect(array.my_each.is_a?(Enumerable)).to eql(array.to_enum.is_a?(Enumerable))
    end

    it 'if the block is given returns an array ' do
      expect(array.my_each { |num| num }).to eql([1, 2, 3, 4])
    end

    it 'if the block is given returns an array' do
      expect(array.my_each { |num| num }).to_not eql([])
    end

    it 'if the block is given returns a range ' do
      expect(range.my_each { |num| num }).to eql((1..10))
    end
  end

  describe '#my_each_with_index' do
    it 'if no block is given it returns an enumerator' do
      expect(array.my_each_with_index.is_a?(Enumerable)).to eql(array.to_enum.is_a?(Enumerable))
    end

    it 'returns a hash with the index equel the value of key' do
      %w[rock paper scissors].each_with_index { |item, index| hash[item] = index }
      expect(hash).to eql({ 'rock' => 0, 'paper' => 1, 'scissors' => 2 })
    end

    it 'if the block is given returns an array' do
      expect(range.my_each_with_index { |num| num }).to eql((1..10))
    end

    it 'if the block is given returns an array' do
      expect(range.my_each_with_index { |num| num }).to_not eql([])
    end
  end

  describe '#my_select' do
    it 'if the block is given returns a range' do
      expect(range.my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end

    it 'if the block is given returns a even number' do
      expect(range.my_select(&:even?)).to eql([2, 4, 6, 8, 10])
    end

    it 'if the block is given returns a even number' do
      expect(range.my_select(&:even?)).to_not eql([])
    end
  end

  describe '#my_count' do
    it 'if a block and arguments is not given returns a count number' do
      expect(array.my_count)
    end

    it 'if an arguments is given returns a count' do
      expect(array.my_count(2))
    end

    it 'if a block and arguments is given returns a count number' do
      expect(array.my_count(&:even?)).to eql(2)
    end

    it 'if a block and arguments is given returns a count number' do
      expect(array.my_count(&:even?)).to_not eql(0)
    end
  end
  # rubocop: enable Metrics/BlockLength
end
