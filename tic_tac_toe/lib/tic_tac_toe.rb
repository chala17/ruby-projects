# frozen_string_literal: true

# lib/tic_tac_toe.rb

# keeps the state of everyone playing
class Player
  attr_accessor :spaces
  attr_reader :player, :symbol

  def initialize(player, symbol, spaces)
    @player = player
    @symbol = symbol
    @spaces = spaces
  end

  def winner?
    winning_arrays = [[0, 1, 2], [0, 3, 6], [0, 4, 8], [1, 4, 7], [2, 5, 8], [3, 4, 5], [6, 7, 8], [2, 4, 6]]
    winning_arrays.any? { |a| a.all? { |num| @spaces.include?(num) } }
  end
end

# keeps the state of the gameboard
class Board
  attr_accessor :spaces

  def initialize(spaces)
    @spaces = spaces
  end

  def display_board(display_mode)
    board = @spaces
    board = Array(0..8) if display_mode == 'spaces'
    (0..8).each do |space|
      if space != 2 && space != 5 && space != 8
        print " #{board[space]} |"
      elsif space != 8
        puts " #{board[space]} \n___|___|___"
      else
        puts " #{board[space]} \n   |   |   "
      end
    end
  end

  def space_taken?(choice)
    unless @spaces[choice] == ' '
      puts "Sorry #{choice} is taken, try another spot!"
      return false
    end
    true
  end
end

def initialize_players
  # initialize players with their symbol choices
  symbol = nil
  until %w[X O].include? symbol
    puts 'Player1 would you like to be X or O?'
    symbol = gets.chomp.upcase
    puts 'Invalid input, X or O only' unless %w[X O].include? symbol
  end
  player1 = Player.new(1, symbol, [])
  symbol = symbol == 'X' ? 'O' : 'X'
  puts "Well Player2 looks like that makes you #{symbol}! \n"
  player2 = Player.new(2, symbol, [])
  return player1, player2
end

def initialize_gameboard
  gameboard = Board.new(Array.new(9, ' '))
  puts "\n Let's start a new game \nHere's what the gameboard looks like\n "
  gameboard.display_board('gameplay')
  puts "\n When asked to pick a space, pick a number from 0-8, corresponding to the spaces on the board\n "
  gameboard.display_board('spaces')
  puts "\n Please pick a space that hasn't been picked yet! \n "
  gameboard
end

def gameplay(player1, player2, gameboard)
  round = 1
  player = player1
  until player.winner?
    return false if round > 9

    player = round.even? ? player2 : player1
    puts "Player#{player.player} looks like it's your turn, choose the space you'd like to go."
    choice = gets.chomp.to_i
    choice = gets.chomp.to_i until gameboard.space_taken?(choice)
    player.spaces.push(choice)
    gameboard.spaces[choice] = player.symbol
    gameboard.display_board('gameplay')
    round += 1
  end
  player
end

def display_winner(winner)
  if winner == false
    puts 'Cats game! Nobody won :('
  else
    puts "Player#{winner.player} you won! Congrats!"
  end
end

def play_again?
  puts 'Would you like to play again? Y/N'
  play_again = gets.chomp.upcase
  until %w[N Y].include? play_again
    puts "Please enter 'Y' or 'N'"
    play_again = gets.chomp.upcase
  end
  return true if play_again == 'Y'

  false
end

def main_logic
  puts 'Hello! Welcome to tic-tac-toe!'
  playing = true
  while playing
    player1, player2 = initialize_players
    gameboard = initialize_gameboard
    winner = gameplay(player1, player2, gameboard)
    display_winner(winner)
    playing = play_again?
  end
  puts 'See ya later! Thanks for playing!'
end

main_logic
