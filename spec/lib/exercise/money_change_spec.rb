module Exercise
  RSpec.describe '#money_change' do
    include Exercise

    specify do
      expect(money_change(2)).to eq(2)
      expect(money_change(28)).to eq(6)
    end
  end
end
