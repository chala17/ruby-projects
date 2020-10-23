 # frozen-string-literal: true

require './pieces.rb'

class Gameboard

  attr_accessor :board 

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

  def capture?(stop)
  end

  def move_piece(start, stop)
  end

  def check?
  end

  def checkmate?
  end
end

game = Gameboard.new
game.display_board