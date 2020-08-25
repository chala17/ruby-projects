def bubblesort(input_array)

  # get length of array
  n = input_array.length

  # initialize variable to start and end w hile loop, w hle loop runs u ntil there are no more numbers to swap
  swap = true
  while (swap == true) do
    swap = false

    # step through numbers 2 at a time so they can be compared
    for i in (0..(n - 2)) do

      # compare numbers to see whether they need to be swapped
      if input_array[i] > input_array[i+1]

        # swaps the numbers
        input_array[i], input_array[i+1] = input_array[i+1], input_array[i]

        # set swap to true so that the outer loop keeps running, there is still work to be done
        swap = true
      end
    end

    # reduce the length of the array so elements that have already bubbled to the top aren't re-analyzed
    n -= 1
  end
  return input_array
end