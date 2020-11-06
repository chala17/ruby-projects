# frozen-string-literal: true

class Player

  attr_accessor :color, :player, :check

  def initialize(player, color)
    @player = player
    @color = color
    @check = false
  end

  def own_piece?(space, board)
    piece = board.board[space[0]][space[1]]
    return false if piece == ' '

    return true if piece.color == color

    false
  end
end