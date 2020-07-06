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

    def match(text)
      match_positions = []
      text.size.times do |start|
        node = 0
        start.upto(text.size - 1) do |offset|
          edge = @adjacency[node] && @adjacency[node].find { |e| e.label == text[offset] }
          break unless edge
          node = edge.destination
        end
        match_positions << start if @adjacency[node].nil?
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
