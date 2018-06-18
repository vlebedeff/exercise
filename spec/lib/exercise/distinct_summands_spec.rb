module Exercise
  RSpec.describe '#distinct_summands' do
    include Exercise

    specify do
      expect(distinct_summands(6)).to eq([1, 2, 3])
      expect(distinct_summands(8)).to eq([1, 2, 5])
      expect(distinct_summands(2)).to eq([2])
    end
  end
end
