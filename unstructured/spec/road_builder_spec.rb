require 'spec_helper'
require 'road_builder'

describe RoadBuilder do
  shared_examples 'road builder' do |points, cost|
    specify do
      expect(RoadBuilder.new(points).cost).to be_within(1E-9).of(cost)
    end
  end

  it_behaves_like 'road builder', [[0, 0], [0, 1], [1, 0], [1, 1]], 3
  it_behaves_like 'road builder', [[0, 0], [0, 2], [1, 1], [3, 0], [3, 2]], 7.064495102
  it_behaves_like 'road builder', [[0, 0], [1, 0], [2, 0], [3, 0], [3, 1]], 4
end
