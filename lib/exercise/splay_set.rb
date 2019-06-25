module Exercise
  class SplaySet # rubocop:disable Metrics/ClassLength
    attr_reader :node, :path

    def initialize(node: nil, path: Stack.new(nil, nil, 0))
      @node = node
      @path = path
    end

    def empty?
      node.nil?
    end

    def insert(value)
      return SplaySet.new(node: Node.new(value)) if empty?
      set = find(value)
      return set.splay if set.node.value == value
      new_node = Node.new(value)
      if new_node.value > set.node.value
        SplaySet.new(node: set.node.attach_right(new_node), path: set.path).go_right.splay
      else
        SplaySet.new(node: set.node.attach_left(new_node), path: set.path).go_left.splay
      end
    end

    def split
      return [self, self] if empty?
      [SplaySet.new(node: node.left), SplaySet.new(node: node.right)]
    end

    def join(another)
      return self if another.empty?
      return another if empty?
      parent, child = node.rank >= another.node.rank ? [self, another] : [another, self]
      insertion_point = parent.find(child.node.value)
      new_node =
        if insertion_point.node.value > child.node.value
          insertion_point.node.attach_left(child.node)
        else
          insertion_point.node.attach_right(child.node)
        end
      SplaySet.new(node: new_node, path: insertion_point.path).splay
    end

    def delete(value)
      set = find(value).splay
      return set if set.node.value != value
      set1, set2 = set.split
      set1.join(set2)
    end

    def go_left
      return self unless node.left
      SplaySet.new(node: node.left, path: path.push(Step.new(node, :left)))
    end

    def go_right
      return self unless node.right
      SplaySet.new(node: node.right, path: path.push(Step.new(node, :right)))
    end

    def find(value)
      return nil if empty?
      z = self
      loop do
        if z.node.value < value && z.node.right
          z = z.go_right
        elsif z.node.value > value && z.node.left
          z = z.go_left
        else
          return z
        end
      end
    end

    def sum(range)
      return 0 if empty?
      splay_left = find(range.begin).splay
      prune_left = SplaySet.new(node: splay_left.node.prune_left)
      splay_right = prune_left.find(range.end).splay
      prune_right = SplaySet.new(node: splay_right.node.prune_right)
      prune_right.node.sum
    end

    def splay # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      z = self
      while z.path.any?
        parent = z.path.last.node
        grandparent = z.path.prev.value && z.path.prev.value.node
        z =
          if z.path.size == 1 && z.path.last.direction == :left
            new_right = parent.attach_left(z.node.right)
            SplaySet.new(node: z.node.attach_right(new_right))
          elsif z.path.size == 1 && z.path.last.direction == :right
            new_left = parent.attach_right(z.node.left)
            SplaySet.new(node: z.node.attach_left(new_left))
          else
            new_path = z.path.pop.pop
            if z.path.last.direction == :left && z.path.prev.value.direction == :left
              new_right =
                parent.attach_right(grandparent.attach_left(parent.right)).attach_left(z.node.right)
              SplaySet.new(node: z.node.attach_right(new_right), path: new_path)
            elsif z.path.last.direction == :right && z.path.prev.value.direction == :right
              new_left =
                parent.attach_left(grandparent.attach_right(parent.left)).attach_right(z.node.left)
              SplaySet.new(node: z.node.attach_left(new_left), path: new_path)
            elsif z.path.last.direction == :left && z.path.prev.value.direction == :right
              new_left = grandparent.attach_right(z.node.left)
              new_right = parent.attach_left(z.node.right)
              new_node = Node.new(z.node.value, new_left, new_right)
              SplaySet.new(node: new_node, path: new_path)
            elsif z.path.last.direction == :right && z.path.prev.value.direction == :left
              new_left = parent.attach_right(z.node.left)
              new_right = grandparent.attach_left(z.node.right)
              new_node = Node.new(z.node.value, new_left, new_right)
              SplaySet.new(node: new_node, path: new_path)
            end
          end
      end
      z
    end

    ###########################################

    Node = Struct.new(:value, :left, :right) do # rubocop:disable Metrics/BlockLength
      def attach_left(node)
        Node.new(value, node, right)
      end

      def attach_right(node)
        Node.new(value, left, node)
      end

      def prune_left
        Node.new(value, nil, right)
      end

      def prune_right
        Node.new(value, left, nil)
      end

      def sum
        @sum ||=
          begin
            l_sum = left ? left.sum : 0
            r_sum = right ? right.sum : 0
            l_sum + value + r_sum
          end
      end

      def rank
        @rank ||=
          begin
            self_rank = 0
            left_rank = left ? left.rank + 1 : 0
            right_rank = right ? right.rank + 1 : 0
            [left_rank, right_rank, self_rank].max
          end
      end
    end

    ###########################################

    Stack = Struct.new(:value, :prev, :size) do
      def push(value)
        Stack.new(value, self, size + 1)
      end

      def pop
        prev
      end

      def last
        value
      end

      def any?
        !value.nil?
      end
    end

    ###########################################

    Step = Struct.new(:node, :direction)
  end
end
