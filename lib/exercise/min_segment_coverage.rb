module Exercise
  # Calculates the minimum number of points so that each given segment contains at least one point
  #
  # @param segments [Array<Array(Integer, Integer)>] line segments
  # @return points [Array<Number>]
  def min_segment_coverage(segments)
    segments.sort_by(&:last).reduce([]) do |points, (from, to)|
      points.any? && (from..to).cover?(points.last) ? points : points + [to]
    end
  end
end
