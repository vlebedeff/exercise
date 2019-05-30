module Exercise
  class SplaySet
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

    def splay
      z = self
      while z.path.any?
        z =
          if z.path.size == 1 && z.path.last.direction == :left
            new_right = z.path.last.node.attach_left(z.node.right)
            SplaySet.new(node: node.attach_right(new_right))
          elsif z.path.size == 1 && z.path.last.direction == :right
            new_left = z.path.last.node.attach_right(z.node.left)
            SplaySet.new(node: node.attach_left(new_left))
          else
            grandparent = z.path.prev.value.node
            parent = z.path.last.node
            if z.path.last.direction == :left && z.path.prev.value.direction == :left
              new_right = parent.attach_right(grandparent.attach_left(parent.right)).attach_left(z.node.right)
              SplaySet.new(node: z.node.attach_right(new_right), path: z.path.pop.pop)
            elsif z.path.last.direction == :left && z.path.prev.value.direction == :right
              new_left = grandparent.attach_right(z.node.left)
              new_right = parent.attach_left(z.node.right)
              SplaySet.new(node: z.node.attach_left(new_left).attach_right(new_right), path: z.path.pop.pop)
            elsif z.path.last.direction == :right && z.path.prev.value.direction == :left
              new_left = parent.attach_right(z.node.left)
              new_right = grandparent.attach_left(z.node.right)
              SplaySet.new(node: z.node.attach_left(new_left).attach_right(new_right), path: z.path.pop.pop)
            elsif z.path.last.direction == :right && z.path.prev.value.direction == :right
              new_left = parent.attach_left(grandparent.attach_right(parent.left)).attach_right(z.node.left)
              SplaySet.new(node: z.node.attach_left(new_left), path: z.path.pop.pop)
            end
          end
      end
      z
    end

    ###########################################

    Node = Struct.new(:value, :left, :right) do
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
