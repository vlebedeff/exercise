require 'graph'

class RoadBuilder
  def initialize(points = [])
    @points = points
  end

  def cost
    graph = Graph.new(false)
    @points.each_with_index do |point, i|
      0.upto(i - 1) do |j|
        graph.add_edge(i, j, distance(i, j))
      end
    end
    graph.prim.last.values.reduce(:+)
  end

  private

  def distance(point_a_index, point_b_index)
    point_a, point_b = @points[point_a_index], @points[point_b_index]
    Math.sqrt(
      (point_a.first - point_b.first) ** 2 + 
      (point_a.last - point_b.last) ** 2
    )
  end
end
