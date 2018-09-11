module Exercise
  def range_search(points, ranges)
    return [] if points.empty?
    ps = (0..points.size - 1).map { |i| [i, :p] }
    ls = ranges.map { |r| [r.begin, :l] }
    rs = ranges.map { |r| [r.end, :r] }
    sorted = (ps + ls + rs).sort_by do |value, type|
      type == :p ? [points[value], type] : [value, type]
    end
    count = 0
    counts = Array.new(points.size) { 0 }
    sorted.each do |value, type|
      case type
      when :p then counts[value] = count
      when :l then count += 1
      when :r then count -= 1
      end
    end
    counts
  end
end
