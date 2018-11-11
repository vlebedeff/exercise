module Exercise
  RSpec::Matchers.define :be_a_min_heap do
    match do |actual|
      0.upto((actual.size - 1) / 2 - 1).map do |parent_index|
        child_index1 = parent_index * 2 + 1
        child_index2 = parent_index * 2 + 2
        gt_child1 = actual[parent_index] <= actual[child_index1]
        gt_child2 = child_index2 >= actual.size || actual[parent_index] <= actual[child_index2]
        gt_child1 && gt_child2
      end.all?
    end
  end

  RSpec.describe Heap do
    describe '#values' do
      context 'when empty' do
        specify do
          expect(described_class.new([]).values).to eq([])
        end
      end

      specify do
        examples = [
          [55, 25, 77, 20, 4, 55, 53, 32],
          [92, 17, 16, 90, 62, 45, 79],
          [61, 9, 76, 90, 23, 38, 93],
          [92, 67, 80, 16]
        ] + Array.new(100) { Array.new(rand(1..100)) { rand(100) } }
        aggregate_failures do
          examples.each do |example|
            expect(described_class.new(example).values).to be_a_min_heap
          end
        end
      end

      it 'logs swaps' do
        swaps = []
        described_class.new([61, 9, 76, 90, 23, 38, 93]) { |i, j| swaps << [i, j] }
        expect(swaps).to eq([[2, 5], [0, 1], [1, 4]])
      end
    end
  end
end
