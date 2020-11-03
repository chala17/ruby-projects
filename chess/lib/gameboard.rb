# frozen-string-literal: true

require_relative 'gameplay'
require_relative 'pieces'
require_relative 'players'

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

  def check?(color)
    symbol = color == 'black' ? "\u2654" : "\u265a"
     king_space = nil
     (0..7).each do |row|
      (0..7).each do |column|
        unless board[row][column] == ' '
          if self.board[row][column].symbol == symbol
            king_space = [row, column]
            break
          end
        end
      end
    end
    enemy_pieces = pieces_set('enemy', color)
    enemy_pieces.each do |piece|
      return true if board[piece[0]][piece[1]].valid_move?(piece, king_space, self)
    end
    false
  end

  def valid_num?(num)
    return false unless num > -1 && num < 8
    true
  end

  def checkmate?(color, king_space)
    mock_board = Gameboard.new 
    board_copy = Marshal.dump(self.board)
    mock_board.board = Marshal.load(board_copy)
    king_moves = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
    valid_possible_moves = []
    king_moves.each do |move|
      possible_move = [king_space[0] + move[0], king_space[1] + move[1]]
      next unless valid_num?(possible_move[0]) && valid_num?(possible_move[1])
      if board[king_space[0]][king_space[1]].valid_move?(king_space, possible_move, self)
        mock_board.move_piece(king_space, possible_move)
        return false unless mock_board.check?(color)

        mock_board.board = Marshal.load(board_copy)
      end
    end
    enemy_pieces = pieces_set('enemy', color)
    friendly_pieces = pieces_set('friend', color)
    enemy_pieces.each do |enemy|
      if board[enemy[0]][enemy[1]].valid_move?(enemy, king_space, self)
        friendly_pieces.each do |friend|
          if board[friend[0]][friend[1]].valid_move?(friend, enemy, self)
            mock_board.move_piece(friend, enemy)
            return false unless mock_board.check?(color)

            mock_board.board = Marshal.load(board_copy)
          end
          if ["\u2656", "\u265c", "\u2657", "\u265d", "\u2655", "\u265b"].include?(board[enemy[0]][enemy[1]].symbol)
            path = path_to_king(enemy, king_space)
            path.each do |path_space|
              unless ["\u2654", "\u265a"].include?(board[friend[0]][friend[1]].symbol)
                if board[friend[0]][friend[1]].valid_move?(friend, path_space, self)
                  mock_board.move_piece(friend, path_space)
                  return false unless mock_board.check?(color)

                  mock_board.board = Marshal.load(board_copy)
                end
              end
            end
          end
        end
      end
    end
    true
  end

  def path_to_king(start, stop)
    start_check = start.clone
    stop_check = stop.clone
    path = []
    if (start[0] - stop[0]).abs == (start[1] - stop[1]).abs
      vertical_adjustment = start_check[0] - stop_check[0] > 0 ? -1 : 1
      horizontal_adjustment = start_check[1] - stop_check[1] > 0 ? -1 : 1
      stop_check[0] -= vertical_adjustment 
      stop_check[1] -= horizontal_adjustment
      until start_check == stop_check
        start_check[0] += vertical_adjustment
        start_check[1] += horizontal_adjustment
        path.append([start_check[0], start_check[1]])
      end
    else
      if start[0] - stop[0] == 0
        ((([start[1], stop[1]].min) + 1)..(([start[1], stop[1]].max) - 1)).each do |i|
          path.append([start_check[0], i])
        end
      else
        ((([start[0], stop[0]].min) + 1)..(([start[0], stop[0]].max) - 1)).each do |i|
          path.append([i, start_check[1]])
        end
      end
    end
    path
  end

  def pieces_set(friend_enemy, color)
    pieces_set = []
    (0..7).each do |row|
      (0..7).each do |column|
        unless board[row][column] == ' '
          piece = board[row][column]
          if friend_enemy == 'friend' ? piece.color == color : piece.color != color
            pieces_set.append([row, column])
          end
        end
      end
    end
    pieces_set
  end
end
