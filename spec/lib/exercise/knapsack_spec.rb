RSpec.describe Exercise do
  include Exercise

  describe '#knapsack_fractional' do
    specify do
      expect(knapsack_fractional(50, [[60, 20], [100, 50], [120, 30]])).to eq(180.0)
      expect(knapsack_fractional(10, [[500, 30]])).to eq(166.6667)
      expect(knapsack_fractional(1000, [[500, 30]])).to eq(500.0)
    end
  end

  describe '#knapsack_integral' do
    specify do
      expect(knapsack_integral(15, [1, 3, 5, 8, 13])).to eq(14)
    end
  end
end
