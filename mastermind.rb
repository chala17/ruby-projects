# frozen-string-literal: true

# 
class CodeBreaker
  def initialize(guess)
    @guess = guess
  end
end

# parent class that contains variables and methods computer and player will need for code making logic
class CodeMaker
  @@colors = %w[r y g b p o]

  def initialize(code, feedback)
    @code = code  # array
    @feedback = feedback  # array
  end

  def generate_feedback(guess)
    check_array = @code.clone

    # checks color and node
    checked_exact = guess.each_with_index.map do | element, index |
      if element == check_array[index]
        element = 'b'
        check_array[index] = ' '
      end
    end

    # checks color of remaining
    checked_similar = checked_exact.map do |element|
      if check_array.include?(element)
        element = 'w'
        check_array[check_array.index(element)] = ' '
      end
    end

    # replaces all colors that weren't found with blank spaces
    checked_similar.map do |element|
      element = ' ' if ['b', 'w'].include?(element)
    end
  end

  def check_guess(guess)
    @code.eql?(guess)
  end

end

# 
class PlayerMaker < CodeBreaker
end

# 
class ComputerBreaker < CodeBreaker
end

# 
class PlayerMaker < CodeMaker
end

# 
class ComputerMaker < CodeMaker
  def initialize(code, feedback)
    super
  end

  def generate_code
    @code = Array.new(4) { colors.sample }
  end
end

# displays the gameboard with the previous guesses and feedback, updates each time
class Gameboard
  def initialize(guesses, feedback)
    @guesses = guesses
    @feedback = feedback
  end
end

def start_game
  puts "WELCOME TO MASTERMIND"
  puts "Would you like to be the code maker, or the code breaker?\n1. Code Maker \n2. Code Breaker"
  breaker_or_maker = gets.chomp.to_i
  code_breaker if breaker_or_maker == 1
  code_maker if breaker_or_maker == 2
end

def code_breaker
  puts "The rules for Code Breaker are thus:\nThe computer will pick a secret code 4 nodes long from the following colors [red, yellow, green, blue, pink, orange]"
  puts "The computer may use a color more than once it it so chooses.\nYour task is to figure out the secret code by guessing the correct colors, in the correct order. "
  puts "You will have 12 guesses to figure out the secret code.\nAfter each guess you will get feedback depending on how close you are to the secret code."
  puts "The feedback will be a code of white and black 4 nodes long.\nIf you guess a color in the code in the right spot, the feedback will be a black node in that same spot."
  puts 'If you guess a color that is in the secret code, but it is in the wrong spot, you will get a white node in the spot of the color that you guessed.'
  puts "If you guessed a color that wasn't in the secret code, you will receive a blank node at that spot.\nGOOD LUCK!!!"
  puts '[press enter to continue]'
  continue = gets.chomp until continue == '\n'
  computer = ComputerMaker.new([],[])