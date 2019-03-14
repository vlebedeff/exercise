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

    describe '#each_pre_order' do
      specify { expect(tree1.each_pre_order.to_a).to eq([4, 2, 1, 3, 5]) }

      specify { expect(tree2.each_pre_order.to_a).to eq([0, 70, 50, 40, 30, 80, 90, 20, 60, 10]) }
    end

    describe '#each_post_order' do
      specify { expect(tree1.each_post_order.to_a).to eq([1, 3, 2, 5, 4]) }

      specify { expect(tree2.each_post_order.to_a).to eq([50, 80, 90, 30, 40, 70, 10, 60, 20, 0]) }
    end
  end
end
