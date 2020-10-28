 # frozen-string-literal: true

require './pieces.rb'

class Gameboard

  attr_accessor :board, :p1_captured, :p2_captured

  def initialize
    @p1_captured = []
    @p2_captured = []
    @board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
    [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
    [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
    [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
  end

  def display_board
    row = 0
    print '    0   1   2   3   4   5   6   7'
    board.each do |arr|
      puts "\n  ---------------------------------"
      print "#{row} |"
      arr.each { |element| print " #{element == ' ' ? element : element.symbol} |" }
      row += 1
    end
    puts "\n  ---------------------------------"
  end

  def capture(stop, player)
    piece = board[stop[0]][stop[1]]
    player.player == 1 ? p1_captured.push(piece) : p2_captured.push(piece)
  end

  def space_occupied?(space)
    return true unless board[space[0]][space[1]] == ' '

    false
  end

  def move_piece(start, stop)
    piece = board[start[0]][start[1]]
    board[start[0]][start[1]] = ' '
    board[stop[0]][stop[1]] = piece
    piece
  end

  def check?
  end

  def checkmate?
  end
end

game = Gameboard.new
game.display_board