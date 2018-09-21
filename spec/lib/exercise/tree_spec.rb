module Exercise
  RSpec.describe Tree do
    describe '#height' do
      let(:examples) do
        {
          3 => [4, -1, 4, 1, 1],
          4 => [-1, 0, 4, 0, 3],
          1 => [-1]
        }
      end

      specify do
        examples.each do |expected_height, parent_index|
          expect(described_class.new(parent_index).height).to eq(expected_height)
        end
      end
    end
  end
end
