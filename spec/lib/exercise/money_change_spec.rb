module Exercise
  RSpec.describe '#money_change' do
    include Exercise

    let(:coin_denominations) { [10, 5, 1] }

    let(:examples) do
      [
        [2,  [10, 5, 1], 2],
        [28, [10, 5, 1], 6],
        [40, [25, 20, 10, 5, 1], 2]
      ]
    end

    specify do
      examples.each do |money, denominations, num_coins|
        expect(money_change(money, denominations)).to eq(num_coins)
      end
    end
  end
end
