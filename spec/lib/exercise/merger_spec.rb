RSpec.describe Exercise::Merger do
  let(:examples) do
    [
      {
        items: [1, 1, 1, 1, 1],
        merges: {
          [2, 4] => 2,
          [1, 3] => 2,
          [0, 3] => 3,
          [4, 3] => 5,
          [4, 2] => 5
        }
      },
      {
        items: [8, 0, 5, 0, 4, 3],
        merges: {
          [5, 5] => 8,
          [5, 4] => 8,
          [4, 3] => 8,
          [3, 2] => 12
        }
      }
    ]
  end

  specify do
    examples.each_with_index do |ex, i|
      merger = described_class.new(ex[:items])
      aggregate_failures do
        ex[:merges].each do |(a, b), max_size|
          expect(merger.merge(a, b)).to(
            eq(max_size),
            "Ex. #{i}: merging #{a} and #{b} expected to result in maximum size of #{max_size}"
          )
        end
      end
    end
  end
end
