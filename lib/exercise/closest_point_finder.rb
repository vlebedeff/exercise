module Exercise
  class ClosestPointFinder
    attr_reader :points

    def initialize(points)
      @points = points
      @result = Result.new(Point.new(-Float::INFINITY), Point.new(Float::INFINITY))
    end

    def distance
      @distance ||=
        begin
          points_by_x = sort(points, :x)
          sort(points_by_x, :y)
          @result.distance
        end
    end

    private

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def sort(points, axis = :x)
      return points if points.count < 2
      m = points.count / 2
      a = sort(points[0..m - 1], axis)
      b = sort(points[m..-1], axis)
      c = merge(a, b, axis)
      if axis == :y
        middle = points[m - 1].x
        z = Point.new(Float::INFINITY)
        p1 = z
        p2 = z
        p3 = z
        p4 = z
        c.each do |point|
          next unless (point.x - middle).abs < @result.distance
          d1 = p1.distance_to(point)
          d2 = p2.distance_to(point)
          d3 = p3.distance_to(point)
          d4 = p4.distance_to(point)
          @result = Result.new(p1, point) if d1 < @result.distance
          @result = Result.new(p2, point) if d2 < @result.distance
          @result = Result.new(p3, point) if d3 < @result.distance
          @result = Result.new(p4, point) if d4 < @result.distance
          p1 = p2
          p2 = p3
          p3 = p4
          p4 = point
        end
      end
      c
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

    def merge(a, b, axis)
      c = []
      while a.any? && b.any?
        c << if a[0].public_send(axis) <= b[0].public_send(axis)
               a.shift
             else
               b.shift
             end
      end
      c + a + b
    end

    class Result
      attr_reader :a, :b

      def initialize(a, b)
        @a = a
        @b = b
      end

      def distance
        @distance ||= a.distance_to(b)
      end
    end
  end
end
