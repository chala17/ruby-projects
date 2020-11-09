# frozen-string-literal: true

# contains method to identify if a piece belongs to that player
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
