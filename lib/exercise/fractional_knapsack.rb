module Exercise
  # Calculates the maximum fractional value that can fit into a knapsack of given capacity
  # @param capacity [Integer] the capacity of a knapsack
  # @param items [Array<Array(Integer, Integer)>]
  #   list of items represented with pairs of value and weight
  # @return value [Number] maximum value for the given capacity
  def fractional_knapsack(capacity, items) # rubocop:disable Metrics/AbcSize
    sorted_items = items.sort_by { |value, weight| weight.to_f / value }
    target_value = 0
    left_capacity = capacity
    while left_capacity > 0 && sorted_items.any?
      value, weight = sorted_items.shift
      item_fraction = [1, Rational(left_capacity, weight)].min
      target_value += item_fraction * value
      left_capacity -= item_fraction * weight
    end
    target_value.to_f.round(4)
  end
end
