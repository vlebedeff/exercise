module Exercise
  # Finds the minimum number of line charts such that no lines on an overlaid chart cross or touch
  # each other
  def minimum_non_intersecting_charts(lines)
    matching = Matching.new(lines.size, lines.size)
    lines.size.times do |i|
      lines.size.times do |j|
        matching.match!(i, j) if line_under?(lines, i, j)
      end
    end
    best_match = matching.best
    lines.size - best_match.compact.count
  end

  def line_under?(lines, i, j)
    lines[i].size.times.reduce(true) { |acc, x| acc && lines[i][x] < lines[j][x] }
  end

  class Matching
    def initialize(count_x, count_y)
      @count_x = count_x
      @count_y = count_y
      @matrix = Array.new(count_x) { Array.new(count_y) { 0 } }
    end

    def match!(i, j)
      @matrix[i][j] = 1
    end

    def best
      size = count_x + count_y + 2
      network = Network.new(size)
      count_x.times do |ix|
        network.add_capacity!(size - 2, ix, 1)
        @matrix[ix].each_with_index do |match, j|
          network.add_capacity!(ix, count_x + j, match)
        end
      end
      count_y.times { |iy| network.add_capacity!(count_x + iy, size - 1, 1) }
      max_flow = network.max_flow(size - 2, size - 1)
      Array.new(count_x) do |ix|
        j = max_flow[ix].index { |flow| flow > 0 }
        j && j - count_x
      end
    end

    private

    attr_reader :count_x, :count_y
  end

  class Network
    def initialize(size)
      @size = size
      @adjacency = Array.new(size) { Array.new(size) { 0 } }
    end

    def add_capacity!(i, j, capacity)
      adjacency[i][j] += capacity
    end

    def capacity(i, j)
      adjacency[i][j]
    end

    def copy
      Network.new(adjacency.size).tap do |n|
        adjacency.each_with_index do |row, i|
          row.each_with_index { |capacity, j| n.add_capacity!(i, j, capacity) }
        end
      end
    end

    def max_flow(src, dest) # rubocop:disable CyclomaticComplexity, PerceivedComplexity
      residual = copy
      loop do # rubocop:disable BlockLength
        previous       = []
        previous[src]  = src
        queue          = [src]
        found          = false
        while !queue.empty? && !found
          u = queue.shift
          @adjacency[u].size.times do |v|
            next if residual.capacity(u, v).zero? || u == v || previous[v]
            queue << v
            previous[v] = u
            found       = v == dest
            break if found
          end
        end

        break unless found

        v = dest
        min_added_flow = Float::INFINITY
        while v != src
          residual_to_v = residual.capacity(previous[v], v)
          min_added_flow = residual_to_v if residual_to_v < min_added_flow
          v = previous[v]
        end

        break unless min_added_flow > 0

        v = dest
        while v != src
          residual.add_capacity!(previous[v], v, -min_added_flow)
          residual.add_capacity!(v, previous[v], min_added_flow)
          v = previous[v]
        end
      end

      Array.new(size) { |i| Array.new(size) { |j| capacity(i, j) - residual.capacity(i, j) } }
    end

    def max_flow_total(src, dest)
      flow = max_flow(src, dest)
      size.times.reduce(0) { |total, i| total + flow[i][dest] }
    end

    private

    attr_reader :adjacency, :size
  end
end

if $PROGRAM_NAME == __FILE__
  include Exercise # rubocop:disable MixinUsage
  line_count, _point_count = gets.strip.split(' ').map(&:to_i)
  lines = Array.new(line_count) { gets.strip.split(' ').map(&:to_i) }
  solution = minimum_non_intersecting_charts(lines)
  puts solution
end
