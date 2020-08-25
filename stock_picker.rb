def stock_picker(stock_array)

  # return statement to prevent error from too few elements in stock array
  if stock_array.length < 2
    return puts "You need more than one day of stocks, you're never going to make it in finance"
  end

  # initialize variables that hold the most profitable stocks
  best_stocks = [0, 1]
  biggest_profit = stock_array[1] - stock_array[0]

  # walk through each element in stock array
  stock_array.each_with_index do |current_number, current_index|

    # walk through remaining elements in stock array
    stock_array[current_index+1,(stock_array.length-(current_index+1))].each_with_index do |next_number, next_index|

      # check whether buying/selling on these days creates a bigger profit than you have so far, when successful set variables to current elements
      if next_number - current_number > biggest_profit 
        biggest_profit = next_number - current_number
        best_stocks = [current_index, next_index + current_index + 1]
      end
    end
  end
  return best_stocks
end