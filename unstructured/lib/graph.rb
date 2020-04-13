BellmandFordTraversal = Struct.new(:distances, :has_negative_weight_cycles)

class Graph
  def initialize(is_directed = false)
    @is_directed = is_directed
    @adjacency = Hash.new { |h, k| h[k] = [] }
    @vertices = []
  end

  def add_edge(v1, v2, weight = 1)
    @vertices.push(v1) unless @vertices.include?(v1)
    @vertices.push(v2) unless @vertices.include?(v2)
    @adjacency[v1].push({ vertex: v2, weight: weight })
    @adjacency[v2].push({ vertex: v1, weight: weight }) unless @is_directed
  end

  def shortest_path(v1, v2)
    dijkstra(v1)[v2]
  end

  def dijkstra(s)
    dist = Hash.new(Float::INFINITY)
    dist[s] = 0
    queue = @vertices
    while queue.any?
      u = queue.min_by { |v| dist[v] }
      queue.delete(u)
      @adjacency[u].each do |edge|
        if dist[edge[:vertex]] > dist[u] + edge[:weight]
          dist[edge[:vertex]] = dist[u] + edge[:weight]
        end
      end
    end
    dist
  end

  def has_negative_weight_cycles?
    with_universal_source { bellman_ford(:SOURCE).has_negative_weight_cycles }
  end

  def bellman_ford(source)
    traversal = BellmandFordTraversal.new(Hash.new(Float::INFINITY), false)
    traversal.distances[source] = 0
    prev = {}
    (@vertices.count - 1).times do
      @adjacency.each do |v, edges|
        edges.each do |edge|
          maybe_relaxed_distance = traversal.distances[v] + edge[:weight]
          if maybe_relaxed_distance < traversal.distances[edge[:vertex]]
            traversal.distances[edge[:vertex]] = maybe_relaxed_distance
            prev[edge[:vertex]] = v
          end
        end
      end
    end
    2.times do
      @adjacency.each do |v, edges|
        edges.each do |edge|
          relaxable = (traversal.distances[edge[:vertex]] > traversal.distances[v] + edge[:weight]) ||
              traversal.distances[prev[v]] == -Float::INFINITY
          if relaxable
            prev[edge[:vertex]] = v
            traversal.has_negative_weight_cycles = true
            traversal.distances[edge[:vertex]] = -Float::INFINITY
          end
        end
      end
    end
    traversal
  end

  def prim
    cost = Hash.new(Float::INFINITY)
    parent = Hash.new
    cost[@vertices.first] = 0
    priority = @vertices.dup
    queue = Hash.new(true)
    priority.count.times do |i|
      v = priority.min_by { |p| queue[p] ? cost[p] : Float::INFINITY }
      queue[v] = false
      @adjacency[v].each do |edge|
        if queue[edge[:vertex]] && cost[edge[:vertex]] > edge[:weight]
          cost[edge[:vertex]] = edge[:weight]
          parent[edge[:vertex]] = v
        end
      end
    end
    [parent, cost]
  end

  private

  def with_universal_source
    @vertices.each { |v| add_edge(:SOURCE, v, 1) }
    @adjacency[:SOURCE] = @vertices.map { |v| { vertex: v, weight: 0 } }
    @vertices << :SOURCE
    result = yield
    @adjacency[:SOURCE] = nil
    @vertices.pop
    result
  end
end
