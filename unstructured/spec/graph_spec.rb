require 'spec_helper'
require 'graph'

describe Graph do
  describe '#shortest_path' do
    let(:graph_1) { build(:graph_1) }
    let(:graph_2) { build(:graph_2) }
    let(:graph_3) { build(:graph_3) }

    specify do
      expect(graph_1.shortest_path(1, 3)).to eq(3)
      expect(graph_2.shortest_path(1, 5)).to eq(6)
      expect(graph_3.shortest_path(3, 2)).to eq(Float::INFINITY)
    end
  end

  describe '#has_negative_weight_cycles?' do
    let(:graph_4) { build(:graph_4) }
    let(:graph_5) { build(:graph_5) }
    let(:graph_6) { build(:graph_6) }

    specify do
      expect(graph_4.has_negative_weight_cycles?).to eq(true)
      expect(graph_5.has_negative_weight_cycles?).to eq(false)
      expect(graph_6.has_negative_weight_cycles?).to eq(true)
    end
  end

  describe '#bellman_ford' do
    let(:graph_7) { build(:graph_7) }
    let(:graph_8) { build(:graph_8) }
    let(:graph_9) { build(:graph_9) }
    let(:graph_11) { build(:graph_11) }

    specify do
      distances = graph_7.bellman_ford(1).distances
      expect(distances[1]).to eq(0)
      expect(distances[2]).to eq(10)
      expect(distances[3]).to eq(-Float::INFINITY)
      expect(distances[4]).to eq(-Float::INFINITY)
      expect(distances[5]).to eq(-Float::INFINITY)
      expect(distances[6]).to eq(Float::INFINITY)
    end

    specify do
      distances = graph_8.bellman_ford(4).distances
      expect(distances[1]).to eq(-Float::INFINITY)
      expect(distances[2]).to eq(-Float::INFINITY)
      expect(distances[3]).to eq(-Float::INFINITY)
      expect(distances[4]).to eq(0)
      expect(distances[5]).to eq(Float::INFINITY)
    end

    specify do
      distances = graph_9.bellman_ford(1).distances
      expect(distances[1]).to eq(0)
      expect(distances[2]).to eq(Float::INFINITY)
      expect(distances[3]).to eq(Float::INFINITY)
      expect(distances[4]).to eq(1)
      expect(distances[5]).to eq(1)
      expect(distances[6]).to eq(1)
    end

    specify do
      distances = graph_11.bellman_ford(1).distances
      expect(distances[1]).to eq(-Float::INFINITY)
      expect(distances[2]).to eq(-Float::INFINITY)
      expect(distances[3]).to eq(-Float::INFINITY)
      expect(distances[4]).to eq(-Float::INFINITY)
      expect(distances[5]).to eq(-Float::INFINITY)
    end
  end
end
