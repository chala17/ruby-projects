# frozen-string-literal: true

class Player

  attr_accessor :player, :symbol

  def initialize(one_or_two, symbol)
    @player = one_or_two
    @symbol = symbol
  end

  def make_a_move(board)
    puts "Enter which column you'd like to drop your token in Player#{self.player}"
    move = gets.chomp.to_i until !move.nil? && move >= 0 && move < 8
    board.spaces[move].push(self.symbol)
  end
end

class Board

  attr_accessor :spaces

  def initialize
    @spaces = Array.new(6, [])
  end

  def display_board
    
  end

  def vertical?(player, move)

  end

  def horizontal?(player, move)

  end

  def diagonal?(player, move)

  end

  def winner?(player, move)
    diagonal?(player, move) || horizontal?(player, move) || vertical?(player, move)
  end
end