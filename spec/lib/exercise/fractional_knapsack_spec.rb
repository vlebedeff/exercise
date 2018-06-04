module Exercise
  RSpec.describe '#fractinal_knapsack' do
    include Exercise

    specify do
      expect(fractional_knapsack(50, [[60, 20], [100, 50], [120, 30]])).to eq(180.0)
      expect(fractional_knapsack(10, [[500, 30]])).to eq(166.6667)
      expect(fractional_knapsack(1000, [[500, 30]])).to eq(500.0)
    end
  end
end
