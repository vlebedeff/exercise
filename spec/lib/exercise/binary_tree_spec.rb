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

    let(:full_binary_tree) do
      BinaryTree.new(
        [
          [4, 1, 2],
          [2, 3, 4],
          [6, 5, 6],
          [1],
          [3],
          [5],
          [7]
        ]
      )
    end

    let(:unbalanced_tree) do
      BinaryTree.new(
        [
          [1, nil, 1],
          [2, nil, 2],
          [3, nil, 3],
          [4, nil, 4],
          [5]
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

    describe '#searchable?' do
      specify do
        expect(tree1.searchable?).to eq(true)
        expect(tree2.searchable?).not_to eq(true)
        expect(full_binary_tree.searchable?).to eq(true)
        expect(unbalanced_tree.searchable?).to eq(true)
      end

      context 'when tree contains duplicates' do
        let(:tree_with_duplicates_in_right) do
          BinaryTree.new(
            [
              [2, 1, 2],
              [1],
              [2]
            ]
          )
        end

        let(:tree_with_duplicates_in_left) do
          BinaryTree.new(
            [
              [2, 1, 2],
              [2],
              [3]
            ]
          )
        end

        specify do
          expect(tree_with_duplicates_in_right.searchable?).to eq(true)
        end

        specify do
          expect(tree_with_duplicates_in_left.searchable?).to eq(false)
        end
      end
    end
  end
end
