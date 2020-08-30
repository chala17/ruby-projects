class Player

  attr_accessor :spaces
  attr_reader :player

  def initialize(player,symbol,spaces)
    @player = player
    @symbol = symbol
    @spaces = spaces
  end
end

class Board
  def initialize(spaces1, spaces2)
    @spaces1 = spaces1
    @spaces2 = spaces2
  end
end

def begin_game()
  puts "Hello players! Welcome to Tic-Tac-Toe!"

  #initialize players with their symbol choices
  while(true)
    puts "Player1 would you like to be X or O?"
    symbol = gets.chomp.upcase
    unless symbol == "X" || symbol == "O"
      puts "Invalid input, X or O only"
      next
    end
    player1 = Player.new(1, symbol, [])
    symbol == 'X' ? symbol = 'O' : symbol = 'X'
    puts "Well Player2 looks like that makes you #{symbol}!"
    player2 = Player.new(2, symbol, [])
  return player1, player2
  end
end

player1, player2 = begin_game()