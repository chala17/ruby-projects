# frozen_string_literal: true

require_relative 'gallows'

class Game
  include Gallows

  attr_reader :guesses

  def initialize
    @secret_word = get_secret_word
    @incorrect_letters = []
    @correct_letters = []
    @guesses = 6
  end

  def display
    guessed_letters = @secret_word.split("").map do |letter| 
      if @correct_letters.include?(letter)
        letter
      else
        "_"
      end
    end
    case @guesses
    when 6
      missed_0
    when 5
      missed_1
    when 4
      missed_2
    when 3
      missed_3
    when 2
      missed_4
    when 1
      missed_5
    when 0
      missed_6
    end
    puts "Your word progress so far is: #{guessed_letters.join(' ')}."
    puts "The letters you've guessed incorrectly are: #{@incorrect_letters.empty? ? 'None yet!' : @incorrect_letters.join(',')}."
    @guesses == 1 ? puts('You have 1 guess left!') : puts("You have #{@guesses} guesses left.")
  end

  def get_secret_word
    dictionary = File.open('../hangman.txt').readlines
    word = 'bad'
    word = dictionary[rand(dictionary.length)].chomp.downcase until word.length > 4 && word.length < 13
    word
  end

  def get_guess
    puts "Please enter a letter you'd like to guess!"
    player_guess = gets.chomp.downcase
    while (@incorrect_letters.include?(player_guess) || @correct_letters.include?(player_guess)) && !is_a_letter(player_guess)
      puts "Invalid entry, please enter a singular letter you haven't yet guessed"
      player_guess = gets.chomp.downcase
    end
    player_guess
  end

  def is_a_letter(letter)
    return false unless letter.is_a? String
    letter.match(/[a-z]/) && letter.length == 1
  end

  def correct_letter(letter)
    if @secret_word.include?(letter)
      @correct_letters << letter
      puts 'Good job! You guessed a letter in the secret word!'
    else
      @incorrect_letters << letter
      @guesses -= 1
      puts 'Swing and a miss!'
    end
  end

  def out_of_guesses
    puts "Oh no! You've ran out of guesses!\nThe word was #{@secret_word} if you were wondering!" if @guesses == 0
    @guesses == 0
  end

  def game_won
    answer = true
    @secret_word.split('').each do |char|
      answer = false unless @correct_letters.include?(char)
    end
    puts "Congrats! You've guessed the secret word!" if answer
    answer
  end
end

def introduction
  puts 'Hello! Welcome to Hangman!'
  puts 'The rules of the game are as follows:'
  puts 'The computer will randomly pick a word.'
  puts 'You must choose letters that you think are in the word.'
  puts 'If you choose a letter that is not in the word it counts as a miss.'
  puts 'You win the game if you successfully guess all the letters in the word.'
  puts 'You lose the game if you miss on 6 letters.'
  puts 'There will be an updated display of the game after each turn.'
  puts "Goodluck! \n\n"
  game = Game.new
  game.display
  return game
end

def play_again
  puts "Enter 'y' if you'd like to play again!"
  response = gets.chomp.downcase
  response == 'y'
end


def logic
  game = introduction
  winner = false
  until winner
    player_guess = game.get_guess
    game.correct_letter(player_guess)
    game.display
    winner = true if game.out_of_guesses || game.game_won
  end
  play_again ? logic : puts("See ya later!")
end

logic