# spec../enumerables

# rubocop: disable Metrics/BlockLength

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

  describe '#my_map' do
    it 'if a block given returns a count number' do
      expect(array.my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'if no block is given an enumerator is returned' do
      expect(array.my_map { 'cake' }).to eql(%w[cake cake cake cake])
    end
  end

  describe '#my_all?' do
    it 'if no block is given and none of the items are false or nil returns true' do
      expect([].my_all?).to eql(true)
    end

    it 'if no block is given and at least one of the items are false or nil returns false' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'if every element in the array items return true for the condition then returns true ' do
      expect(%w[cake chocolate lolipop].my_all? { |word| word.length >= 4 }).to eql(true)
    end

    it 'if one or more of the elements in the array returns false for the condition then returns false' do
      expect(%w[cake chocolate lolipop].my_all? { |word| word.length >= 5 }).to eql(false)
    end

    it 'returns whether pattern === element for every collection member' do
      expect(%w[cake chocolate lolipop].my_all?(/t/)).to eql(false)
    end

    it 'returns whether pattern === element for every collection member' do
      expect(%w[cake chocolate candy].my_all?(/c/)).to_not eql(false)
    end

    it 'returns true if every element is a member of a given class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'if no block is given and no items are true returns false ' do
      expect([].my_any?).to eql(false)
    end

    it 'if no block is given and one or more items are true returns true ' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'if one or more elements in the array returns true then true' do
      expect(%w[cake chocolate lolipop].my_any? { |word| word.length >= 4 }).to eql(true)
    end

    it 'if one or more elements in the array returns true then true' do
      expect(%w[cake chocolate lolipop].my_any? { |word| word.length >= 8 }).to eql(true)
    end

    it 'returns whether pattern === element for any collection member' do
      expect(%w[cake chocolate lolipop].my_any?(/d/)).to eql(false)
    end

    it 'returns whether pattern === element for any collection member' do
      expect(%w[cake chocolate lolipop].my_any?(/l/)).to_not eql(false)
    end
  end

  describe '#my_none?' do
    it 'if no block is given and no items are true returns true ' do
      expect([nil, false].my_none?).to eql(true)
    end

    it 'returns false if no block is given and at least one of the items are true returns false' do
      expect([nil, false, true].my_none?).to eql(false)
    end

    it 'if none of the elements in the array returns true for the condition returns true' do
      expect(%w[cake chocolate lolipop].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'if at least one of the elements returns true for the condition returns false' do
      expect(%w[cake chocolate lolipop].my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns whether pattern === element for none collection member' do
      expect(%w[cake chocolate lolipop].my_none?(/d/)).to eql(true)
    end

    it 'returns whether pattern === element for none collection member' do
      expect(%w[cake chocolate lolipop].my_none?(/l/)).to_not eql(true)
    end
  end

  describe '#my_inject?' do
    it 'returns the sum of the items when the input is a range and no initial value is given' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
    end

    it 'returns the sum of the items and the initial when a symbol and initial value is given instead of a block' do
      expect((5..10).my_inject(10) { |sum, n| sum + n }).to_not eql(45)
    end

    it 'returns the sum of the items and the initial value when the input is a range and initial value is given' do
      expect((5..10).my_inject(10) { |sum, n| sum + n }).to eql(55)
    end

    it 'returns the sum of the items when a symbol is given instead of a block' do
      expect((5..10).my_inject(:+)).to eql(45)
    end

    it 'returns the sum of the items and initial when a symbol and initial value is given instead of a block' do
      expect((5..10).my_inject(6, :+)).to eql(51)
    end

    it 'returns word with the biggest lenght in the array, stored in the accumulator variable' do
      expect(%w[cat sheep bear].my_inject { |memo, word| memo.length > word.length ? memo : word }).to eql('sheep')
    end
  end

  describe '#multiply_els' do
    it 'returns the multiplication of each item in an array' do
      expect(multiply_els([2, 4, 5])).to eql(40)
    end

    it 'returns the multiplication of each item in a range' do
      expect(multiply_els(5..10)).to_not eql(9)
    end
  end
end

# rubocop: enable Metrics/BlockLength
