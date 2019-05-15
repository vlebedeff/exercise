RSpec.describe Exercise::SplaySet do
  describe '#empty?' do
    subject { described_class.new.empty? }

    it { is_expected.to eq(true) }

    context 'when node is set' do
      let(:node) { Exercise::SplaySet::Node.new(0) }

      subject { described_class.new(node: node).empty? }

      it { is_expected.to eq(false) }
    end
  end
end
