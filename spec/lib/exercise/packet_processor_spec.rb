RSpec.describe Exercise::PacketProcessor do
  let(:examples) do
    {
      [1, []] => [],
      [1, [[0, 0]]] => [0],
      [1, [[0, 1], [0, 1]]] => [0, -1],
      [1, [[0, 1], [1, 1]]] => [0, 1],
      [1, [[1, 0]]] => [1],
      [1, [[0, 1], [2, 1]]] => [0, 2]
    }
  end

  specify do
    examples.each do |(buffer_size, packets), expected_processed_packets|
      expect(
        described_class.new(buffer_size, packets).process.map(&:started_at)
      ).to eq(expected_processed_packets)
    end
  end
end
