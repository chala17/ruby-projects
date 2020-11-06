# frozen-string-literal: true

class Piece

  attr_accessor :color

  def initialize(color)
    @color = color
  end

end

class Pawn < Piece

  attr_accessor :symbol, :moved
  
  def initialize(color)
    super(color)
    @moved = false
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2659" : "\u265f"
  end

  def valid_move?(start, stop, gameboard)
    return true if en_passant(gameboard, start, stop)
    if color == 'white'
      if (start[1] - stop[1]).abs == 1 && start[0] - stop[0] == 1
        return false if gameboard.board[stop[0]][stop[1]] == ' '

        if ((gameboard.board[start[0]][start[1]]).color != (gameboard.board[stop[0]][stop[1]]).color)
          self.moved = true
          return true
        else
          return false
        end
      end
      return false if gameboard.space_occupied?(stop)

      return false unless start[1] - stop[1] == 0

      if self.moved == false
        if start[0] - stop[0] == 2
          self.moved = true
          return true
        end
      end
      if start[0] - stop[0] == 1
        self.moved = true
        return true
      end
    else
      if (start[1] - stop[1]).abs == 1 && start[0] - stop[0] == -1
        return false if gameboard.board[stop[0]][stop[1]] == ' '

        if ((gameboard.board[start[0]][start[1]]).color != (gameboard.board[stop[0]][stop[1]]).color)
          self.moved = true
          return true
        else
          return false
        end
      end
      return false if gameboard.space_occupied?(stop)

      return false unless start[1] - stop[1] == 0
      if self.moved == false
        if start[0] - stop[0] == -2
          self.moved = true
          return true
        end
      end
      if start[0] - stop[0] == -1
        self.moved = true
        return true
      end
    end
    false
  end

  def en_passant(gameboard, start, stop)
    return false if gameboard.moves_array.empty?

    return false unless gameboard.moves_array[-1][0].is_a?(Pawn)

    return false unless [(gameboard.moves_array[-1][1][0] + gameboard.moves_array[-1][2][0]) / 2.0, gameboard.moves_array[-1][2][1]] == stop
    gameboard.board[gameboard.moves_array[-1][2][0]][gameboard.moves_array[-1][2][1]] = ' '
    true
  end

  def promotion(stop, board, piece)
    puts "Congrats, you can promote your pawn!"
    options = %w[r k b q]
    entry = ' '
    until options.include?(entry)
      puts "Choose one of these letters\nr: rook\nk: knight\nb: bishop\nq: queen"
      entry = gets.chomp.downcase
      puts("That was an unacceptable entry") unless options.include?(entry)
    end
    case entry
    when 'r'
      board.board[stop[0]][stop[1]] = Rook.new(piece.color)
    when 'k'
      board.board[stop[0]][stop[1]] = Knight.new(piece.color)
    when 'b'
      board.board[stop[0]][stop[1]] = Bishop.new(piece.color)
    when 'q'
      board.board[stop[0]][stop[1]] = Queen.new(piece.color)
    end
  end
end

class Rook < Piece

  attr_accessor :symbol, :moved

  def initialize(color)
    super(color)
    @moved = false
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2656" : "\u265c"
  end

  def valid_move?(start, stop, gameboard)
    return false unless start[0] - stop[0] == 0 || start[1] - stop[1] == 0

    if start[0] - stop[0] == 0
      # steps from min number to max number, checking i/f there's a piece along the way
      ((([start[1], stop[1]].min) + 1)..(([start[1], stop[1]].max) - 1)).each do |i|
        return false unless gameboard.board[start[0]][i] == ' '

      end
    else
      ((([start[0], stop[0]].min) + 1)..(([start[0], stop[0]].max) - 1)).each do |i|
        return false unless gameboard.board[i][start[1]] == ' '

      end
    end
    self.moved = true
    true
  end
end

class Knight < Piece

  attr_accessor :symbol

  def initialize(color)
    super(color)
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2658" : "\u265e"
  end

  def valid_move?(start, stop, gameboard)
    moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    moves.each do |move|
      move[0] += start[0]
      move[1] += start[1]
      return true if move == stop
    end
    false
  end

end

class Bishop < Piece

  attr_accessor :symbol

  def initialize(color)
    super(color)
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2657" : "\u265d"
  end

  def valid_move?(start, stop, gameboard)
    return false unless (start[0] - stop[0]).abs == (start[1] - stop[1]).abs

    start_check = start.clone
    stop_check = stop.clone
    vertical_adjustment = start_check[0] - stop_check[0] > 0 ? -1 : 1
    horizontal_adjustment = start_check[1] - stop_check[1] > 0 ? -1 : 1
    stop_check[0] -= vertical_adjustment 
    stop_check[1] -= horizontal_adjustment
    until start_check == stop_check
      start_check[0] += vertical_adjustment
      start_check[1] += horizontal_adjustment
      return false unless gameboard.board[start_check[0]][start_check[1]] == ' '
    end
    true
  end
end

class Queen < Piece

  attr_accessor :symbol
  
  def initialize(color)
    super(color)
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2655" : "\u265b"
  end

  # combined bishops and rooks move logic
  def valid_move?(start, stop, gameboard)
    if (start[0] - stop[0]).abs == (start[1] - stop[1]).abs
      start_check = start.clone
      stop_check = stop.clone
      vertical_adjustment = start_check[0] - stop_check[0] > 0 ? -1 : 1
      horizontal_adjustment = start_check[1] - stop_check[1] > 0 ? -1 : 1
      stop_check[0] -= vertical_adjustment 
      stop_check[1] -= horizontal_adjustment
      until start_check == stop_check
        start_check[0] += vertical_adjustment
        start_check[1] += horizontal_adjustment
        return false unless gameboard.board[start_check[0]][start_check[1]] == ' '
      end
      return true
    end
    if start[0] - stop[0] == 0 || start[1] - stop[1] == 0
      if start[0] - stop[0] == 0
        # steps from min number to max number, checking i/f there's a piece along the way
        ((([start[1], stop[1]].min) + 1)..(([start[1], stop[1]].max) - 1)).each do |i|
          return false unless gameboard.board[start[0]][i] == ' '

        end
      else
        ((([start[0], stop[0]].min) + 1)..(([start[0], stop[0]].max) - 1)).each do |i|
          return false unless gameboard.board[i][start[1]] == ' '

        end
      end
      return true
    end
    false
  end
end

class King < Piece

  attr_accessor :symbol, :moved
  
  def initialize(color)
    super(color)
    @symbol = assign_unicode
    @moved = false
  end

  def assign_unicode
    color == 'black' ? "\u2654" : "\u265a"
  end

  def valid_move?(start, stop, gameboard)
    if (start[0] - stop[0]).abs <= 1 && (start[1] - stop[1]).abs <= 1
      if gameboard.space_occupied?(stop)
        return false if gameboard.board[stop[0]][stop[1]].color == color
      end
      mock_board = Gameboard.new 
      board_copy = Marshal.dump(gameboard.board)
      mock_board.board = Marshal.load(board_copy)
      mock_board.move_piece(start, stop)
      return false if mock_board.check?(mock_board.board[stop[0]][stop[1]].color)

      self.moved = true
      return true
    end
    
    false
  end
end