RSpec.describe '#majority_element' do
  include Exercise

  specify do
    expect(majority_element([2, 3, 9, 2, 2])).to eq(2)
    expect(majority_element([3, 3, 4, 2, 4, 4, 2, 4, 4])).to eq(4)
    expect(majority_element([1, 2, 3, 4])).to eq(nil)
    expect(majority_element([1, 2, 3, 1])).to eq(nil)
    expect(majority_element([3, 3, 4, 2, 4, 4, 2, 4])).to eq(nil)
  end
end
