def substrings(input_string, dictionary)

  #create an array with each word in the input string as an element in the array
  input_array = input_string.downcase.split()

  # create an empty dictionary to store any of the words in the dictionary that are substrings of the input string
  dictionary_hash = {}

  #walk through each word in the input string
  input_array.each do |word|

    #walk through each word in the dictionary
    dictionary.each do |entry|

      #check to see whether the dictionary entry is a substring of the current word in the input string array
      if word.include?(entry)

        # when the dictionary entry is a substring and there isn't already a key in the dictionary hash yet, create one and set the value to 1
        unless dictionary_hash[entry]
          dictionary_hash[entry] = 1

        # in the instance there is already a key, increment by 1
        else
          dictionary_hash[entry] += 1
        end
      end
    end
  end
  return dictionary_hash.sort.to_h
end
