require 'spec_helper'
require 'disjoint_set'

describe DisjointSet do
  let(:disjoint_set) { DisjointSet.new(['A', 'B', 'C']) }

  describe '#size' do
    subject { disjoint_set.size }

    it { is_expected.to eq(3) }
  end

  describe '#find' do
    specify do
      expect(disjoint_set.find('A').name).to eq('A')
      expect(disjoint_set.find('B').name).to eq('B')
      expect(disjoint_set.find('C').name).to eq('C')
    end
  end

  describe '#union' do
    before { disjoint_set.union('A', 'B') }

    it 'updates size' do
      expect(disjoint_set.size).to eq(2)
    end

    it 'attaches A to B' do
      expect(disjoint_set.find('A').root.name).to eq('B')
    end

    context 'when joining elements with different rank' do
      before { disjoint_set.union('B', 'C') }

      it 'attaches lower rank element to higher rank element' do
        expect(disjoint_set.find('C').root.name).to eq('B')
      end
    end

    context 'when repeating union' do
      before { disjoint_set.union('B', 'A') }

      it 'has no effect' do
        expect(disjoint_set.size).to eq(2)
      end
    end
  end
end
