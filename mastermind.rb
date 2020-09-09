# frozen-string-literal: true

# parent class that contains a class variable
class CodeBreaker
  @@colors = %w[r y g b p o]
end

# parent class that contains variables and methods computer and player will need for code making logic
class CodeMaker
  @@colors = %w[r y g b p o]

  def initialize
    @code = []
  end

  def generate_feedback(guess)
    check_array = @code.clone
    # checks color and node

    checked_exact = guess.map.with_index do | element, index |
      if element == check_array[index]
        element = 'bl'
        check_array[index] = ' '
      end
      element
    end

    # checks color of remaining
    checked_similar = checked_exact.map do |element|
      if check_array.include?(element)
        check_array[check_array.index(element)] = ' '
        element = 'w'
      end
      element
    end

    # replaces all colors that weren't found with blank spaces
    checked_similar.map do |element|
      element = ' ' unless ['bl', 'w'].include?(element)
      element
    end
  end

  def correct_guess?(guess)
    @code.eql?(guess)
  end

end

# Additional method to allow players to take a guess at the secret code
class PlayerBreaker < CodeBreaker
  def get_guess
    code_guess = []
    (1..4).each do |num|
      puts "Please pick which color (#{@@colors}) you think is in the #{num} spot of the secret code"
      color_choice = gets.chomp.downcase
      unless @@colors.include?(color_choice)
        puts "That is not an appropriate choice" 
        redo 
      end
      code_guess << color_choice
    end
    code_guess
  end
end

# Additional method that enables the computer to make guesses based upon feedback
class ComputerBreaker < CodeBreaker

  def guess(feedback, last_guess)
    unless feedback
      return Array.new(4) { @@colors.sample }
    end
    new_guess = Array.new(4)
    maybe = []
    feedback.each_with_index do |element, index|
      if element == 'bl'
        new_guess[index] = last_guess[index] 
        next
      elsif maybe != []
        new_guess[index] = maybe.sample
        maybe = maybe - Array(new_guess[index])
        maybe << last_guess[index] if element == 'w'
        next
      else
        maybe << last_guess[index] if element == 'w'
        new_guess[index] = (@@colors - Array(last_guess[index])).sample
      end
    end
    new_guess
  end
end

# Additional method to allow a player to pick their own code
class PlayerMaker < CodeMaker
  def initialize
    @code = make_code()
  end

  def make_code
    code = []
    puts 'Time to pick your secret code!'
    (1..4).each do |num|
      puts "Please pick which color (#{@@colors}) you'd like as the #{num} spot of the secret code"
      color_choice = gets.chomp.downcase
      unless @@colors.include?(color_choice)
        puts "That is not an appropriate choice"
        redo 
      end
      code << color_choice
    end
    puts "Got it, your secret code is: #{code}"
    code
  end
end

# additional method to generate a random secret code
class ComputerMaker < CodeMaker
  def initialize
    @code = generate_code()
  end

  def generate_code
    @code = Array.new(4) { @@colors.sample }
  end
end

# displays the gameboard with the previous guesses and feedback, updates each time
class Gameboard

  attr_accessor :guesses, :feedback

  def initialize
    @guesses = Array.new(12,Array.new(4,'.'))
    @feedback = Array.new(12,Array.new())
  end

  def display_board
    puts "     guesses        feedback"
    12.times do |i|
      puts "|| #{@guesses[i].join(" | ")} || #{@feedback[i]}"
    end
  end

  def play_again?
    puts "Press the 'Y' key if you'd like to play again!"
    player_response = gets.chomp.downcase
    player_response == 'y' ? true : false
  end
end

def start_game
  puts "WELCOME TO MASTERMIND"
  puts "Would you like to be the code breaker, or the code maker?\n1. Code Breaker \n2. Code Maker"
  breaker_or_maker = gets.chomp.to_i
  code_breaker if breaker_or_maker == 1
  code_maker if breaker_or_maker == 2
end

def code_breaker
  puts "The rules for Code Breaker are thus:\nThe computer will pick a secret code 4 nodes long using the following colors [red, yellow, green, blue, pink, orange]"
  puts "The computer may use a color more than once if it so chooses.\nYour task is to figure out the secret code by guessing the correct colors, in the correct order. "
  puts "You will have 12 guesses to figure out the secret code.\nAfter each guess you will get feedback depending on how close you are to the secret code."
  puts "The feedback will be a code of white and black nodes 4 nodes long.\nIf you guess a color of the secret code in the right spot, the feedback will be a black node in that same spot."
  puts 'If you guess a color that is in the secret code, but it is in the wrong spot, you will get a white node in the spot of the color that you guessed.'
  puts "If you guessed a color that wasn't in the secret code, you will receive a blank node at that spot.\nGOOD LUCK!!!"
  puts '[press enter to continue]'
  continue = gets.chomp until continue == ''
  computer = ComputerMaker.new
  player = PlayerBreaker.new
  gameboard = Gameboard.new
  puts 'The computer has picked their code!'
  (1..12).each do |num|
    puts "Round #{num}!"
    player_guess = player.get_guess
    gameboard.guesses[num - 1] = player_guess
    win = computer.correct_guess?(player_guess)
    if win
      puts "Congrats! You picked the computers code! You're a Mastermind!"
      break
    else
      puts 'Not Quite!'
      feedback = computer.generate_feedback(player_guess)
      gameboard.feedback[num - 1] = feedback
      gameboard.display_board
    end
    puts 'Oh no, you ran out of turns! The computer wins this time' if num == 12
  end
  gameboard.play_again? ? start_game : puts("Bye! Hope you had fun!")
end

def code_maker
  puts 'In Code Maker all you need to do is pick a secret code that the computer will try and guess.'
  puts 'The computer will have twelve chances to guess your code.'
  puts 'After each guess the computer will receive automatically generated feedback.'
  puts 'The gameboard will be displayed after each round so you can see if the computer is getting close!'
  puts '[press enter to continue]'
  continue = gets.chomp until continue == ''
  computer = ComputerBreaker.new
  player = PlayerMaker.new
  gameboard = Gameboard.new
  feedback = nil
  computer_guess = []
  (1..12).each do |num|
    puts "Round #{num}"
    computer_guess = computer.guess(feedback, computer_guess)
    gameboard.guesses[num - 1] = computer_guess
    win = player.correct_guess?(computer_guess)
    if win
      puts "The computer guessed your code, you've been bested!"
      break
    else
      puts 'The computer missed this time!'
      feedback = player.generate_feedback(computer_guess)
      gameboard.feedback[num - 1] = feedback
      gameboard.display_board
      puts '[press the number of this round to continue]'
      continue = gets.chomp until continue == "#{num}"
    end
    puts 'Game over! The computer was unable to guess your code! You Win!' if num == 12
  end
  gameboard.play_again? ? start_game : puts("Bye! Hope you had fun!")
end

start_game
