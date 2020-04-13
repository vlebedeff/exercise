class DisjointSet
  attr_reader :size

  def initialize(items = [])
    @elements = items.each_with_object({}) { |i, h| h[i] = Element.new(i) }
    @size = @elements.size
    @rank = Hash.new(0)
  end

  def find(name)
    @elements[name].root
  end

  def union(name_1, name_2)
    root_1, root_2 = @elements[name_1].root, @elements[name_2].root
    return if root_1 == root_2
    if @rank[name_1] > @rank[name_2]
      root_2.parent = root_1
    else
      root_1.parent = root_2
      @rank[name_2] += 1 if @rank[name_1] == @rank[name_2]
    end
    @size -= 1
  end

  class Element
    attr_reader :name
    attr_accessor :parent

    def initialize(name)
      @name = name
      @parent = self
    end

    def root
      while @parent.parent != @parent
        @parent.parent = @parent.parent.parent
        @parent = @parent.parent
      end
      @parent
    end
  end
end
