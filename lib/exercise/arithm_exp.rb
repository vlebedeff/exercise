module Exercise
  class ArithmExp
    def initialize(str)
      @operands, @operations = str.split(/([^\d])/).partition.with_index { |_, i| i.even? }
      @operands = @operands.map(&:to_i)
      @min_max = Array.new(@operands.size) { Array.new(@operands.size) }
    end

    def maximum
      max_at(0, @operands.size - 1)
    end

    def min_max(i, j)
      @min_max[i][j] ||=
        begin
          if i == j
            [@operands[i], @operands[i]]
          else
            min = Float::INFINITY
            max = -Float::INFINITY
            i.upto(j - 1) do |k|
              op = operation(k)
              a = op.call(min_at(i, k), min_at(k + 1, j))
              b = op.call(min_at(i, k), max_at(k + 1, j))
              c = op.call(max_at(i, k), min_at(k + 1, j))
              d = op.call(max_at(i, k), max_at(k + 1, j))
              min = [min, a, b, c, d].min
              max = [max, a, b, c, d].max
            end
            [min, max]
          end
        end
    end

    def min_at(i, j)
      min_max(i, j).first
    end

    def max_at(i, j)
      min_max(i, j).last
    end

    def operation(k)
      case @operations[k]
      when '+' then ->(x, y) { x + y }
      when '-' then ->(x, y) { x - y }
      when '*' then ->(x, y) { x * y }
      else
        raise "Unsupported arithmetic operation `#{@operations[k]}`"
      end
    end
  end
end
