module Exercise
  class Point
    attr_reader :x, :y

    def initialize(x, y = x)
      @x = x
      @y = y
    end

    def distance_to(other)
      dx = x - other.x
      dy = y - other.y
      Math.sqrt(dx**2 + dy**2)
    end

    def ==(other)
      x == other.x && y == other.y
    end
  end
end
