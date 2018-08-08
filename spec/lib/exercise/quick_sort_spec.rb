RSpec.describe '#quick_sort' do
  include Exercise

  specify do
    expect(quick_sort([2, 3, 9, 2, 2])).to eq([2, 2, 2, 3, 9])
  end

  specify 'stress test' do
    100.times do
      items = Array.new(rand(10)) { rand(10) }
      expect(quick_sort(items)).to eq(items.sort), items.inspect
    end
  end
end
