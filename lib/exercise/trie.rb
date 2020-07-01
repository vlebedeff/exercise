module Exercise
  class Trie
    def initialize(patterns)
      adjacency = {}
      node_count = 0
      patterns.each do |pattern|
        parent = 0
        pattern.each_char do |char|
          adjacency[parent] ||= []
          existing_edge = adjacency[parent].find { |_dest, label| char == label }
          if existing_edge
            parent = existing_edge[0]
          else
            node_count += 1
            adjacency[parent] << [node_count, char]
            parent = node_count
          end
        end
      end
      @adjacency = adjacency
    end

    def to_s
      @adjacency
        .flat_map { |src, edges| edges.map { |dest, label| "#{src}->#{dest}:#{label}" } }
        .join("\n")
    end
  end
end
