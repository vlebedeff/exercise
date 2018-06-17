module Exercise
  COIN_DENOMINATIONS = [10, 5, 1].freeze
  # Calculates the minimum number of coins needed to change the given amount of money
  #
  # @param amount [Integer] the amount of money
  # @return [Integer] the number of coins
  def money_change(amount)
    number_of_coins = 0
    while amount > 0
      coin = COIN_DENOMINATIONS.find { |d| d <= amount }
      number_of_coins += amount / coin
      amount = amount % coin
    end
    number_of_coins
  end
end
