module Exercise
  def max_pairwise_product(numbers)
    numbers.sort.last(2).reduce(:*)
  end

  def fib_mod_10(position)
    fib_mod_m_naive(position, 10)
  end

  def gcd(a, b)
    return a if b.zero?
    return b if a.zero?
    a, b = a > b ? [b, a % b] : [a, b % a] while a != b && !b.zero?
    a
  end

  def lcm(a, b)
    a * b / gcd(a, b)
  end

  def pisano_period(m)
    a = 1
    b = 1
    p = 1
    # Pisano Period always starts from 0 1
    a, b, p = [b, (a + b) % m, p + 1] while a != 0 || b != 1
    p
  end

  def fib_mod_m(n, m)
    fib_mod_m_naive(n % pisano_period(m), m)
  end

  def fib_mod_m_naive(n, m)
    return 0 if n.zero?
    return 1 if n == 1
    (1..n).reduce([0, 1]) { |(prev, curr), _| [curr, (prev + curr) % m] }.first
  end

  def fib_sum_mod_10(n)
    reduced_n = n % pisano_period(10)
    return reduced_n if reduced_n < 2
    (1...reduced_n)
      .reduce([0, 1]) { |nums| nums + [(nums[-2] + nums[-1]) % 10] }
      .inject(:+) % 10
  end
end
