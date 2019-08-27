RSpec.describe 'flow' do
  let(:lines) do
    [
      [1, 2, 3, 4],
      [2, 3, 4, 6],
      [6, 5, 4, 3],

      [5, 5, 5],
      [4, 4, 6],
      [4, 5, 4],

      [2, 1002, 2],
      [1005, 5, 1005],
      [6, 1006, 1006],
      [1001, 1, 1],
      [1007, 1007, 1007],
      [4, 4, 1004],
      [0, 0, 0],
      [1003, 1003, 3]
    ]
  end

  describe '#minimum_non_intersecting_charts' do
    specify do
      expect(minimum_non_intersecting_charts(lines[0..2])).to eq(2)
      expect(minimum_non_intersecting_charts(lines[3..5])).to eq(3)
      expect(minimum_non_intersecting_charts(lines[6..13])).to eq(3)
    end
  end

  describe Exercise::Network do
    describe '#max_flow_total' do
      specify do
        network = described_class.new(1)
        expect(network.max_flow_total(0, 0)).to eq(0)
      end

      specify do
        network = described_class.new(2)
        network.add_capacity!(0, 1, 42)
        expect(network.max_flow_total(0, 1)).to eq(42)
      end

      specify do
        network = described_class.new(5)
        network.add_capacity!(0, 1, 10)
        network.add_capacity!(1, 2, 5)
        network.add_capacity!(2, 3, 8)
        network.add_capacity!(3, 4, 12)
        expect(network.max_flow_total(0, 4)).to eq(5)
      end

      specify do
        network = described_class.new(4)
        network.add_capacity!(0, 1, 1_000_000)
        network.add_capacity!(0, 2, 1_000_000)
        network.add_capacity!(1, 3, 1_000_000)
        network.add_capacity!(2, 3, 1_000_000)
        network.add_capacity!(1, 2, 1)
        expect(network.max_flow_total(0, 3)).to eq(2_000_000)
      end

      specify do
        network = described_class.new(9)
        network.add_capacity!(0, 1, 69)
        network.add_capacity!(0, 6, 76)
        network.add_capacity!(1, 2, 95)
        network.add_capacity!(1, 3, 53)
        network.add_capacity!(1, 4, 9)
        network.add_capacity!(1, 7, 85)
        network.add_capacity!(2, 3, 45)
        network.add_capacity!(2, 4, 54)
        network.add_capacity!(3, 6, 13)
        network.add_capacity!(3, 8, 16)
        network.add_capacity!(4, 5, 49)
        network.add_capacity!(4, 8, 24)
        network.add_capacity!(5, 6, 52)
        network.add_capacity!(6, 7, 100)
        network.add_capacity!(6, 8, 3)
        network.add_capacity!(7, 8, 63)
        expect(network.max_flow_total(0, 8)).to eq(106)
      end

      specify do
        network = described_class.new(6)
        network.add_capacity!(4, 0, 1)
        network.add_capacity!(4, 1, 1)
        network.add_capacity!(0, 2, 1)
        network.add_capacity!(0, 3, 1)
        network.add_capacity!(1, 2, 1)
        network.add_capacity!(2, 5, 1)
        network.add_capacity!(3, 5, 1)
        expect(network.max_flow_total(4, 5)).to eq(2)
      end
    end
  end

  describe Exercise::Matching do
    describe '#best' do
      specify do
        matching = described_class.new(2, 2)
        matching.match!(0, 0)
        matching.match!(0, 1)
        matching.match!(1, 0)
        expect(matching.best).to eq([1, 0])
      end
    end
  end
end
