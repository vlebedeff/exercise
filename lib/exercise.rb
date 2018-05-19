module Exercise
  def max_pairwise_product(numbers)
    numbers.sort.last(2).reduce(:*)
  end

  def fib_mod_10(position)
    return 0 if position.zero?
    return 1 if position == 1
    (1..position).reduce([0, 1]) { |(prev, current), _| [current, (prev + current) % 10] }.first
  end

  def gcd(a, b) # rubocop:disable Naming/UncommunicativeMethodParamName
    return a if b.zero?
    return b if a.zero?
    a, b = a > b ? [b, a - b] : [a, b - a] while a != b && a > 1
    a
  end
end
