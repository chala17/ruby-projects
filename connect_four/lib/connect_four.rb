# frozen-string-literal: true

class Player

  attr_accessor :player, :symbol

  def initialize(one_or_two, symbol)
    @player = one_or_two
    @symbol = symbol
  end

  def make_a_move(board)
    accepted_move = false
    until accepted_move
      puts "Enter which column you'd like to drop your token in Player#{self.player}"
      move = gets.chomp.to_i - 1
      until move >= 0 && move <= 5
        puts 'Please enter an integer between 1 and 6!'
        move = gets.chomp.to_i - 1
      end
      if board.spaces[move].length < 6
        board.spaces[move].push(self.symbol)
        accepted_move = true
      else
        puts 'It looks like that column is full!'
      end
    end
    move
  end
end

class Board

  attr_accessor :spaces

  def initialize
    @spaces = [[], [], [], [], [], []]
  end

  def display_board
    5.downto(0) do |row|
      print '|'
      0.upto(5) do |column|
        token = spaces[column].length >= (row + 1) ? spaces[column][row] : '_'
        print "_#{token}_|"
      end
      puts
    end
  end

  def display_labeled_board
    puts 'The columns you can place your tokens in are labeled 1-6 on the board below'
    display_board
    puts '  1   2   3   4   5   6'
  end

  def vertical?(player, move)
    row = spaces[move].length - 1
    1.upto(3) do
      row -= 1
      return false if row < 0

      return false unless spaces[move][row] == player.symbol

    end
    true
  end

  def horizontal?(player, move)
    row = spaces[move].length - 1
    directions = [1, -1]
    0.upto(1) do |direction|
      column = move
      win = true
      1.upto(3) do
        column += directions[direction]
        if (column > 5 || column < 0)
          win = false 
          break
        end
        win = false unless spaces[column][row] == player.symbol
      end
      return true if win
    end
    false
  end

  def diagonal?(player, move)
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    0.upto(3) do |direction|
      row = spaces[move].length - 1
      column = move
      win = true
      1.upto(3) do
        row += directions[direction][0]
        column += directions[direction][1]
        if (row > 5 || row < 0) || (column > 5 || column < 0)
          win = false
          break
        end
        win = false unless spaces[column][row] == player.symbol
      end
      return true if win
    end
    false
  end

  def board_full?
    spaces.each { |index| return false if index.length < 6 }
    true
  end

  def winner?(player, move)
    diagonal?(player, move) || horizontal?(player, move) || vertical?(player, move)
  end
end

class Gameplay

  def create_players
    puts "Hello players! Welcome to Connect Four!\nPlayer1 would you like to be X or O?"
    player1 = gets.chomp.upcase
    until %[X O].include?(player1)
      puts 'Please choose either X or O'
      player1 = gets.chomp.upcase
    end
    player2 = player1 == 'X' ? 'O' : 'X'
    puts "Player2 looks like that makes you #{player2}"
    [Player.new(1, player1), Player.new(2, player2)]
  end

  def play_again?(winner)
    winner == 'cats' ? puts('Cats game!') : puts("Looks like Player#{winner.player} won!")
    puts 'Enter y if you would like to start another game!'
    response = gets.chomp.downcase
    return true if response == 'y'

    false
  end

  def start_game
    player1, player2 = create_players
    board, winner, player = Board.new, false, player2
    board.display_labeled_board
    until winner
      player = player == player1 ? player2 : player1
      move = player.make_a_move(board)
      board.display_board
      winner = 'cats' if board.board_full?
      winner = player if board.winner?(player, move)
    end
    play_again?(winner) ? start_game : puts('See ya later!')
  end
end

game = Gameplay.new
game.start_game
