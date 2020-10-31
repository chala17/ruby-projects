# frozen-string-literal: true

require_relative 'gameboard'
require_relative 'pieces'
require_relative 'gameplay'

class Player

  attr_accessor :color, :player

  def initialize(player, color)
    @player = player
    @color = color
  end

  def own_piece?(space, board)
    piece = board.board[space[0]][space[1]]
    return false if piece == ' '

    return true if piece.color == color

    false
  end
end