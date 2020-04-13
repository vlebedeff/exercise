require 'spec_helper'
require 'btree'

describe BTree do

  let(:tree) { build(:'figure_4.3') }

  describe 'visitors' do

    subject { described_class.foreach(tree.root).map(&:data) }

    describe BTree::PreOrderVisitor do

      it do
        is_expected.to eq(
          ['E', 'O', nil, 'A', 'C', 'P', 'M', 'L', 'T', 'E', 'T', nil, 'E', 'R', 'E']
        )
      end
    end

    describe BTree::InOrderVisitor do

      it do
        is_expected.to eq(
          ['A', nil, 'C', 'O', 'M', 'P', 'L', 'E', 'T', 'E', nil, 'T', 'R', 'E', 'E']
        )
      end
    end

    describe BTree::PostOrderVisitor do
      it do
        is_expected.to eq(
          ['A', 'C', nil, 'M', 'L', 'P', 'O', 'T', nil, 'E', 'R', 'E', 'E', 'T', 'E']
        )
      end
    end

    describe BTree::LevelOrderVisitor do
      it do
        is_expected.to eq(
          ['E', 'O', 'T', nil, 'P', 'E', 'E', 'A', 'C', 'M', 'L', 'T', nil, 'R', 'E']
        )
      end
    end
  end
end
