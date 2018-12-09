module Exercise
  class Merger
    def initialize(items = [])
      @sizes = items
      @max = @sizes.max
      @dset = DisjointSet.new((0...@sizes.count).to_a)
    end

    def merge(a, b)
      @max = [
        @dset.union(a, b) { |parent, child| @sizes[parent] += @sizes[child] } || 0,
        @max
      ].max
    end
  end
end
