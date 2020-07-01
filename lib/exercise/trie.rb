module Exercise
  class Trie
    Edge = Struct.new(:destination, :label)

    def initialize(patterns)
      adjacency = {}
      node_count = 0
      patterns.each do |pattern|
        parent = 0
        pattern.each_char do |char|
          adjacency[parent] ||= []
          existing_edge = adjacency[parent].find { |edge| edge.label == char }
          if existing_edge
            parent = existing_edge.destination
          else
            node_count += 1
            adjacency[parent] << Edge.new(node_count, char)
            parent = node_count
          end
        end
      end
      @adjacency = adjacency
    end

    def to_s
      @adjacency
        .flat_map { |src, edges| edges.map { |e| "#{src}->#{e.destination}:#{e.label}" } }
        .join("\n")
    end
  end
end
