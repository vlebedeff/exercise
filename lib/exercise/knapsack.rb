module Exercise
  # Calculates the maximum fractional value that can fit into a knapsack of given capacity
  # @param capacity [Integer] the capacity of a knapsack
  # @param items [Array<Array(Integer, Integer)>]
  #   list of items represented with pairs of value and weight
  # @return value [Number] maximum value for the given capacity
  def knapsack_fractional(capacity, items)
    sorted_items = items.sort_by { |value, weight| weight.to_f / value }
    target_value = 0
    left_capacity = capacity
    while left_capacity.positive? && sorted_items.any?
      value, weight = sorted_items.shift
      item_fraction = [1, Rational(left_capacity, weight)].min
      target_value += item_fraction * value
      left_capacity -= item_fraction * weight
    end
    target_value.to_f.round(4)
  end

  def knapsack_integral(capacity, items)
    value = Array.new(capacity + 1) { Array.new(items.size + 1) { 0 } }
    1.upto(items.size) do |i|
      1.upto(capacity) do |c|
        item_value = items[i - 1]
        item_weight = items[i - 1]
        value[c][i] = value[c][i - 1]
        if item_weight <= c
          new_value = value[c - item_weight][i - 1] + item_value
          value[c][i] = new_value if new_value > value[c][i]
        end
      end
    end
    value[capacity][items.size]
  end
end
