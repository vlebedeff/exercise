module Exercise
  def max_pairwise_product(numbers)
    numbers.sort.last(2).reduce(:*)
  end

  def fib_mod_10(position)
    return 0 if position.zero?
    return 1 if position == 1
    (1..position).reduce([0, 1]) { |(prev, current), _| [current, (prev + current) % 10] }.first
  end
end
