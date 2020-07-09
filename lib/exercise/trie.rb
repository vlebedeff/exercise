module Exercise
  class Trie
    Edge = Struct.new(:destination, :label, :eow)

    def initialize(patterns)
      adjacency = {}
      node_count = 0
      patterns.each do |pattern|
        parent = 0
        last_index = pattern.size - 1
        0.upto(last_index) do |i|
          char = pattern[i]
          eow = i == last_index
          adjacency[parent] ||= []
          existing_edge = adjacency[parent].find { |edge| edge.label == char }
          if existing_edge
            parent = existing_edge.destination
            existing_edge.eow = true if eow
          else
            node_count += 1
            adjacency[parent] << Edge.new(node_count, char, eow)
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

    def match(text)
      match_positions = []
      text.size.times do |start|
        node = 0
        edge = nil
        start.upto(text.size - 1) do |offset|
          edge = @adjacency[node] && @adjacency[node].find { |e| e.label == text[offset] }
          break unless edge
          if edge.eow
            match_positions << start
            break
          end
          node = edge.destination
        end
      end
      match_positions
    end
  end
end

if $PROGRAM_NAME == __FILE__
  text = gets.strip
  npatterns = gets.strip.to_i
  patterns = []
  npatterns.times do
    patterns << gets.strip
  end
  trie = Exercise::Trie.new(patterns)
  positions = trie.match(text)
  puts positions.join(' ')
end
