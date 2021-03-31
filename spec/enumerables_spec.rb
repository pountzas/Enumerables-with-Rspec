# frozen_string_literal: true

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
end
