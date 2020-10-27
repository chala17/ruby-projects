# frozen-string-literal: true

class Piece
  
  attr_accessor :color, :moved

  def initialize(color)
    @moved = false
    @color = color
  end

end

class Pawn < Piece

  attr_accessor :symbol
  
  def initialize(color)
    super(color)
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2659" : "\u265f"
  end

  def valid_move?(start, stop, gameboard)
    if color == 'white'
      return gameboard.capture? if (start[0] - stop[0]).abs == 1 && start[1] - stop[1] == 1

      return false unless start[1] - stop[1] == 0

      if moved == false
        return true if start[0] - stop[0] == 2

      end
      return true if start[0] - stop[0] == 1

    else
      return game.capture? if (start[0] - stop[0]).abs == 1 && start[1] - stop[1] == -1

      return false unless start[1] - stop[1] == 0
      
      if moved == false
        return true if start[0] - stop[0] == -2

      end
      return true if start[0] - stop[0] == -1

    end
    false
  end

  def en_passant
  end

end

class Rook < Piece

  attr_accessor :symbol

  def initialize(color)
    super(color)
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

    vertical_adjustment = start[0] - stop[0] > 0 ? -1 : 1
    horizontal_adjustment = start[1] - stop[1] > 0 ? -1 : 1
    stop[0] -= vertical_adjustment 
    stop[1] -= horizontal_adjustment
    until start == stop
      start[0] += vertical_adjustment
      start[1] += horizontal_adjustment
      return false unless gameboard.board[start[0]][start[1]] == ' '
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
      vertical_adjustment = start[0] - stop[0] > 0 ? -1 : 1
      horizontal_adjustment = start[1] - stop[1] > 0 ? -1 : 1
      stop[0] -= vertical_adjustment 
      stop[1] -= horizontal_adjustment
      until start == stop
        start[0] += vertical_adjustment
        start[1] += horizontal_adjustment
        return false unless gameboard.board[start[0]][start[1]] == ' '
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

  attr_accessor :symbol
  
  def initialize(color)
    super(color)
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2654" : "\u265a"
  end

  def valid_move?(start, stop, gameboard)
    return true if (start[0] - stop[0]).abs <= 1 && (start[1] - stop[1]).abs <= 1

    false
  end

  def castle
  end

end