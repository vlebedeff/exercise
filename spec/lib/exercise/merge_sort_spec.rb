RSpec.describe '#merge_sort' do
  include Exercise

  specify do
    100.times do
      items = Array.new(rand(10)) { rand(10) }
      expect(merge_sort(items).first).to eq(items.sort), items.inspect
    end
  end

  specify do
    expect(merge_sort([2, 3, 9, 2, 9]).last).to eq(2)
    expect(merge_sort([1, 20, 6, 4, 5]).last).to eq(5)
    expect(merge_sort([9, 8, 7, 3, 2, 1]).last).to eq(15)
  end
end
