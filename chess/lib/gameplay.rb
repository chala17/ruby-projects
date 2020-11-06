# frozen-string-literal: true

require './gameboard.rb'
require './pieces.rb'
require './players.rb'

class Gameplay

  def valid_entry?(num)
    return false unless num.to_i.to_s == num

    return false unless num.to_i > -1 && num.to_i < 8
    true
  end

  def castling(gameboard, player)
    error_message = 'You were unable to castle your King, please make a regular move'
    enemy_pieces = gameboard.pieces_set('enemy', player.color)
    white_black = player.color == 'black' ? 0 : 7
    return false unless gameboard.board[white_black][4].is_a?(King) && gameboard.board[white_black][4].moved == false
    
    puts 'Would you like to try and castle your King? Press Y if yes'
    answer = gets.chomp.downcase
    return false unless answer == 'y'

    puts 'Press Q to castle Queenside, or K to castle Kingside, anything else will cancel castling.'
    answer = gets.chomp.downcase
    return false unless %w[q k].include?(answer)

    return false if gameboard.check?(player.color)
    
    if answer == 'q'
      unless gameboard.board[white_black][0].is_a?(Rook) && gameboard.board[white_black][0].moved == false
        puts error_message
        return false
      end
      unless gameboard.board[white_black][1] == ' ' && gameboard.board[white_black][2] == ' ' && gameboard.board[white_black][3] == ' '
        puts error_message
        return false
      end
      enemy_pieces.each do |enemy|
        if gameboard.board[enemy[0]][enemy[1]].valid_move?(enemy, [white_black, 1], gameboard) || gameboard.board[enemy[0]][enemy[1]].valid_move?(enemy, [white_black, 2], gameboard) ||
          gameboard.board[enemy[0]][enemy[1]].valid_move?(enemy, [white_black, 3], gameboard)
          puts error_message
          return false
        end
      end
      puts 'You have succesfully castled your King!'
      gameboard.move_piece([white_black, 4], [white_black, 2])
      gameboard.move_piece([white_black, 0], [white_black, 3])
      gameboard.display_board
      return true
    else
      unless gameboard.board[white_black][7].is_a?(Rook) && gameboard.board[white_black][7].moved == false
        puts error_message
        return false
      end
      unless gameboard.board[white_black][5] == ' ' && gameboard.board[white_black][6] == ' '
        puts error_message
        return false
      end
      enemy_pieces.each do |enemy|
        if gameboard.board[enemy[0]][enemy[1]].valid_move?(enemy, [white_black, 5], gameboard) || gameboard.board[enemy[0]][enemy[1]].valid_move?(enemy, [white_black, 6], gameboard)
          puts error_message
          return false
        end
      end
      puts 'You have succesfully castled your King!'
      gameboard.move_piece([white_black, 4], [white_black, 6])
      gameboard.move_piece([white_black, 7], [white_black, 5])
      gameboard.display_board
      return true
    end
  end

  def move_input(player)
    start = []
    stop = []
    counter = 1
    while counter < 5
      entry = -1
      until valid_entry?(entry)
        puts "Player#{player.player} please enter the #{counter.even? ? 'column' : 'row'} #{counter < 3 ? 
        'of the piece that you would like to move' : 'of the space you would like to move your piece to'}."
        entry = gets.chomp
        puts('That is not a valid entry') unless valid_entry?(entry)
      end
      counter < 3 ? start.push(entry.to_i) : stop.push(entry.to_i)
      counter += 1
    end
    return start, stop
  end

  def player_move(player, board)
    start, stop = move_input(player)
    unless player.own_piece?(start, board)
      puts 'You did not pick a space that contains your own piece!'
      player_move(player, board)
      return
    end
    if player.own_piece?(stop, board)
      puts 'The space you picked to move your piece to already contains one of your own pieces!'
      player_move(player, board)
      return
    end
    piece = board.board[start[0]][start[1]]
    if player.check
      mock_board = Gameboard.new 
      board_copy = Marshal.dump(board.board)
      mock_board.board = Marshal.load(board_copy)
      mock_board.move_piece(start, stop)
      if mock_board.check?(player.color)
        puts 'You must move your king out of check!'
        player_move(player, board)
        return
      end
    end
    unless piece.valid_move?(start, stop, board)
      puts 'The piece you chose can not move to the space you specified.'
      player_move(player, board)
      return
    end
    piece = board.move_piece(start, stop)
    piece.promotion(stop, board, piece) if (stop[0] == 0 && piece.symbol == "\u265f") || (stop[0] == 7 && piece.symbol == "\u2659")
    board.display_board
  end

  def game_logic
    board = Gameboard.new
    player1 = Player.new(1, 'white')
    player2 = Player.new(2, 'black')
    round = 1
    game_over = false
    board.display_board
    until game_over
      player = round.odd? ? player1 : player2
      puts "#{player.color}'s turn"
      opposing_player = round.odd? ? player2 : player1
      player_move(player, board) unless castling(board, player)
      if board.check?(opposing_player.color)
        opposing_player.check = true
        if board.checkmate?(opposing_player.color)
          game_over = true
          puts "That's checkmate!\nPlayer#{player.player} it looks like you've won the game!"
        else
          puts "The #{opposing_player.color} King is in check!"
        end
      else
        opposing_player.check = false
      end
      round += 1
    end
  end
end

game = Gameplay.new
game.game_logic