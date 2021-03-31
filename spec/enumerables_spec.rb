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
end
