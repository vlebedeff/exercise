module Exercise
  RSpec.describe BinaryTree do
    let(:tree1) do
      BinaryTree.new(
        [
          [4, 1, 2],
          [2, 3, 4],
          [5],
          [1],
          [3]
        ]
      )
    end

    let(:tree2) do
      BinaryTree.new(
        [
          [0, 7, 2],
          [10],
          [20, nil, 6],
          [30, 8, 9],
          [40, 3],
          [50],
          [60, 1],
          [70, 5, 4],
          [80],
          [90]
        ]
      )
    end

    describe '#each_in_order' do
      specify { expect(tree1.each_in_order.to_a).to eq([1, 2, 3, 4, 5]) }

      specify { expect(tree2.each_in_order.to_a).to eq([50, 70, 80, 30, 90, 40, 0, 20, 10, 60]) }
    end
  end
end
