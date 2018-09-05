module Exercise
  RSpec.describe Point do
    subject(:point) { described_class.new(1) }

    describe '#==' do
      specify do
        expect(subject).to eq(subject)
        expect(subject).to eq(described_class.new(1))
        expect(subject).not_to eq(described_class.new(1, 2))
      end
    end

    describe '#distance_to' do
      specify do
        expect(subject.distance_to(described_class.new(1, 5))).to eq(4)
        expect(subject.distance_to(described_class.new(5, 1))).to eq(4)
        expect(subject.distance_to(described_class.new(5))).to be_within(0.0001).of(5.6568)
      end
    end
  end
end
