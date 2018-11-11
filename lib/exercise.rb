require 'exercise/point'
require 'exercise/money_change'
require 'exercise/knapsack'
require 'exercise/min_segment_coverage'
require 'exercise/distinct_summands'
require 'exercise/max_salary'
require 'exercise/binary_search'
require 'exercise/majority_element'
require 'exercise/quick_sort'
require 'exercise/merge_sort'
require 'exercise/closest_point_finder'
require 'exercise/range_search'
require 'exercise/min_arithmetic_steps'
require 'exercise/edit_distance'
require 'exercise/lcs'
require 'exercise/arithm_exp'
require 'exercise/balanced_partition'
require 'exercise/mismatched_brackets'
require 'exercise/tree'
require 'exercise/packet_processor'
require 'exercise/heap'

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

  def fib_sum_partial_mod_10(m, n)
    pisano_period10 = pisano_period(10)
    reduced_m = m % pisano_period10
    reduced_n = n % pisano_period10
    return reduced_n if reduced_n < 2
    (1...reduced_n)
      .reduce([0, 1]) { |nums| nums + [(nums[-2] + nums[-1]) % 10] }[reduced_m..-1]
      .inject(:+) % 10
  end

  def fib_sum_squared_mod_10(n)
    a = fib_mod_m(n, 10)
    b = fib_mod_m(n + 1, 10)
    (a * b) % 10
  end
end
