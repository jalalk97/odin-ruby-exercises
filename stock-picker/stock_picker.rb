def stock_picker(stock_prices)
  best = [0, 0]
  best_profit = 0
  stock_prices.each_with_index do |buy, i|
    stock_prices.each_with_index do |sell, j|
      next unless i < j

      profit = sell - buy
      next unless profit > best_profit

      best = [i, j]
      best_profit = profit
    end
  end
  best
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
