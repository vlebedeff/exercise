RSpec.describe '#balanced_partition3' do
  include Exercise

  specify do
    expect(balanced_partition3([16, 5, 7, 9, 0, 8, 11, 4, 1, 11])).to eq(true)
    expect(balanced_partition3([5, 4, 11, 16, 4, 0, 6, 12, 13, 12])).to eq(false)
  end
end
