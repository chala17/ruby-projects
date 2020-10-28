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
    @moved = false
    super(color)
    @symbol = assign_unicode
  end

  def assign_unicode
    color == 'black' ? "\u2659" : "\u265f"
  end

  def valid_move?(start, stop, gameboard)
    if color == 'white'
      if (start[1] - stop[1]).abs == 1 && start[0] - stop[0] == 1
        return false if gameboard.board[stop[0]][stop[1]] == ' '

        if ((gameboard.board[start[0]][start[1]]).color != (gameboard.board[stop[0]][stop[1]]).color)
          moved = true
          return true
        else
          return false
        end
      end
      return false if gameboard.space_occupied?(stop)

      return false unless start[1] - stop[1] == 0

      if moved == false
        if start[0] - stop[0] == 2
          moved = true
          return true
        end
      end
      if start[0] - stop[0] == 1
        moved = true
        return true
      end

    else
      if (start[1] - stop[1]).abs == 1 && start[0] - stop[0] == -1
        return false if gameboard.board[stop[0]][stop[1]] == ' '

        if ((gameboard.board[start[0]][start[1]]).color != (gameboard.board[stop[0]][stop[1]]).color)
          moved = true
          return true
        else
          return false
        end
      end
      return false if gameboard.space_occupied?(stop)

      return false unless start[1] - stop[1] == 0
      puts 'here'
      if moved == false
        puts 'here?'
        if start[0] - stop[0] == -2
          moved = true
          return true
        end
      end
      if start[0] - stop[0] == -1
        moved = true
        return true
      end
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