RSpec.describe Exercise::DisjointSet do
  subject(:disjoint_set) { described_class.new(%w[A B C]) }

  describe '#size' do
    subject { disjoint_set.size }

    it { is_expected.to eq(3) }
  end

  describe '#find' do
    specify do
      expect(disjoint_set.find('A')).to eq('A')
      expect(disjoint_set.find('B')).to eq('B')
      expect(disjoint_set.find('C')).to eq('C')
    end
  end

  describe '#union' do
    before { disjoint_set.union('A', 'B') }

    it 'updates size' do
      expect(disjoint_set.size).to eq(2)
    end

    it 'attaches B to A' do
      expect(disjoint_set.find('B')).to eq('A')
    end

    context 'when joining elements with different rank' do
      before { disjoint_set.union('C', 'A') }

      it 'attaches lower rank element to higher rank element' do
        expect(disjoint_set.find('C')).to eq('A')
      end
    end

    context 'when repeating union' do
      before do
        disjoint_set.union('A', 'B')
        disjoint_set.union('B', 'A')
      end

      it 'has no effect' do
        expect(disjoint_set.size).to eq(2)
      end
    end
  end
end
