RSpec.describe '#binary_search' do
  include Exercise

  specify do
    expect(binary_search([799], 799)).to eq(0)
    expect(binary_search([1, 5, 8, 12, 13], 5)).to eq(1)
    expect(binary_search([1, 5, 8, 12, 13], 1)).to eq(0)
    expect(binary_search([1, 5, 8, 12, 13], 13)).to eq(4)
    expect(binary_search([531, 531, 714], 531)).to eq(0)

    expect(binary_search([1, 5, 8, 12, 13], 7)).to eq(nil)
  end

  specify do
    100.times do
      items = Array.new(rand(100)) { rand(1000) }.sort.uniq
      existing_item = items.sample
      non_existing_item = rand(1000..1100)
      expect(binary_search(items, existing_item)).to(
        eq(items.index(existing_item)),
        "#{items.inspect}, #{existing_item}"
      )
      expect(binary_search(items, non_existing_item)).to eq(nil)
    end
  end
end
