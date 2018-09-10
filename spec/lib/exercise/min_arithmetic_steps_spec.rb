module Exercise
  RSpec.describe '#min_arithmetic_steps' do
    include Exercise

    let(:operations) do
      [
        ->(x) { x * 3 },
        ->(x) { x * 2 },
        ->(x) { x + 1 }
      ]
    end

    specify do
      expect(min_arithmetic_steps(42, operations)).to eq([1, 2, 6, 7, 14, 42])
    end
  end
end
