require 'set'

class String
  
  # @return [Boolean] whether a given string is a valid word
  #   according to Letterpress dictionary
  def valid_word?
    system("grep '^#{self}$' letterpress.txt > /dev/null")
  end

  # @return [Boolean] whether there are any valid words that
  #   start with a given string
  def valid_prefix?
    system("grep '^#{self}' letterpress.txt > /dev/null")
  end
end

class Popcorn

  # @param letters [String] all the letters from a puzzle
  # @param adjacency [Array<Array<Integer>>] adjacency list,
  #   where the i-th row holds all indices that the i-th letter is connected with
  def initialize(letters = '', adjacency = [])
    @letters = letters
    @adjacency = adjacency
  end

  # Goes through the puzzle structure and remembers valid words
  # @param path [Array<Integer>] list of indices that were already
  #   hit on the current step
  def advance(path)
    # Don't even start with non-existing prefixes
    if (word = spell(path)).valid_prefix?
      # Remember a word if it's valid
      @words << word if word.valid_word?
      # Select all indicies that are adjacent to the last item
      # only if weren't already passed through
      @adjacency[path.last].select { |i| !path.include?(i) }.each do |item|
        # Continue with an updated path
        advance(path + [item])
      end
    end
  end

  # Build an empty set of words, try to advance starting
  # from every letter index
  # @return [Array<String>] list of detected valid words
  def perform
    @words = Set.new 
    @letters.size.times.each { |i| advance([i]) }
    @words
  end

  private

    def spell(path)
      path.map { |i| @letters[i, 1] }.join
    end
end

popcorn = Popcorn.new(
  'pornapoc',
  [
    [1, 2, 3, 4],
    [0, 3, 4, 5],
    [0, 3, 6],
    [0, 1, 2, 4, 6, 7],
    [0, 1, 3, 5, 6, 7],
    [1, 4, 7],
    [2, 3, 4, 7],
    [3, 4, 5, 6]
  ]
)
popcorn.perform.sort.each { |word| puts word }
