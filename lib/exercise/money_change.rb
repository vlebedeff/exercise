module Exercise
  # Calculates the minimum number of coins needed to change the given amount of money
  #
  # @param amount [Integer] the amount of money
  # @return [Integer] the number of coins
  def money_change(amount, coin_denominations = [1])
    denominations_desc = coin_denominations.sort_by(&:-@)
    min_coins = Array.new(amount + 1) { Float::INFINITY }
    1.upto(amount) do |a|
      denominations_desc.each do |d|
        if a == d
          min_coins[a] = 1
        elsif a > d
          min_coins[a] = [min_coins[a], 1 + min_coins[a - d]].min
        end
      end
    end
    min_coins.last
  end
end
