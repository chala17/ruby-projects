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
    gameboard.display_board
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

  def valid_move?(start, stop, gameboard)
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
  end

  def castle
  end

end