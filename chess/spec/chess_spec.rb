#frozen-string-literal: true

require './lib/gameboard.rb'
require './lib/pieces.rb'
require './lib/players.rb'
require './lib/gameplay.rb'
require 'stringio'

RSpec.describe Pawn do 
  describe '#valid_move?' do
    let(:black_pawn) { Pawn.new('black') }
    let(:gameboard) { Gameboard.new }

    context 'checks for valid moves and returns a boolean. ' do
      it 'returns true when pawn moves by 1' do
        expect(black_pawn.valid_move?([1, 2], [2, 2], gameboard)).to eql(true)
      end

      it 'returns true when pawn moves by 2 on initial move' do
        black_pawn.moved = false
        expect(black_pawn.valid_move?([1, 1], [3, 1], gameboard)).to eql(true)
      end

      it 'returns false when pawn moves by more than one and it is not initial move' do
        black_pawn.moved = true
        expect(black_pawn.valid_move?([2, 2], [4, 2], gameboard)).to eql(false)
      end

      it 'returns false when pawn moves by more than 2' do
        expect(black_pawn.valid_move?([3, 3], [6, 3], gameboard)).to eql(false)
      end

      it 'returns false when pawn tries to move backwards' do
        expect(black_pawn.valid_move?([3, 3], [2, 3], gameboard)).to eql(false)
      end

      it 'returns false when pawn tries to move laterally' do
        expect(black_pawn.valid_move?([1, 4], [1, 3], gameboard)).to eql(false)
      end

      it 'returns true when pawn moves in an attacking fashion and captures a piece' do
        gameboard.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', Pawn.new('white'), ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(black_pawn.valid_move?([1, 0], [2, 1], gameboard)).to eql(true)
      end

      it 'returns false when pawn moves diagonally and does not capture a piece' do
        expect(black_pawn.valid_move?([1, 5], [2, 6], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe Rook do
  describe '#valid_move?' do
    let(:white_rook) { Rook.new('white') }
    let(:gameboard) { Gameboard.new }

    context 'checks for valid moves and returns a boolean. ' do
      it 'returns true when rook moves 1 space vertically' do
        expect(white_rook.valid_move?([1, 1], [2, 1], gameboard)).to eql(true)
      end

      it 'returns true when rook moves more than 1 space vertically' do
        expect(white_rook.valid_move?([1, 3], [4, 3], gameboard)).to eql(true)
      end

      it 'returns true when rook moves 1 space laterally' do
        expect(white_rook.valid_move?([3, 2], [3, 3], gameboard)).to eql(true)
      end

      it 'returns true when rook moves more than 1 space laterally' do
        expect(white_rook.valid_move?([2, 0], [2, 5], gameboard)).to eql(true)
      end

      it 'returns false when rook tries to move diagonally' do
        expect(white_rook.valid_move?([2, 4], [4, 6], gameboard)).to eql(false)
      end

      it 'returns false when rook tries to move through a piece on the board' do
        expect(white_rook.valid_move?([0, 0], [0, 4], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe Knight do
  describe '#valid_move?' do
    let(:white_knight) { Knight.new('white')}
    let(:gameboard) { Gameboard.new }

    context 'checks for valid moves and returns a boolean. ' do
      it 'returns true when piece moves 2up 1left' do
        expect(white_knight.valid_move?([3, 3], [1, 2], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2up 1right' do
        expect(white_knight.valid_move?([3, 3], [1, 4], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2left 1up' do
        expect(white_knight.valid_move?([3, 3], [2, 1], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2left 1 down' do
        expect(white_knight.valid_move?([3, 3], [4, 1], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2down 1left' do
        expect(white_knight.valid_move?([3, 3], [5, 2], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2down 1right' do
        expect(white_knight.valid_move?([3, 3], [5, 4], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2right 1up' do
        expect(white_knight.valid_move?([3, 3], [2, 5], gameboard)).to eql(true)
      end

      it 'returns true when piece moves 2right 1down' do
        expect(white_knight.valid_move?([3, 3], [4, 5], gameboard)).to eql(true)
      end

      it 'returns false when piece moves 3up 1right' do
        expect(white_knight.valid_move?([3, 3], [0, 4], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 4up 1left' do
        expect(white_knight.valid_move?([4, 3], [0, 2], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 3down 1right' do
        expect(white_knight.valid_move?([3, 3], [6, 4], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 4down 1left' do
        expect(white_knight.valid_move?([3, 3], [7, 2], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 3right' do
        expect(white_knight.valid_move?([3, 3], [3, 6], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 3left 1down' do
        expect(white_knight.valid_move?([3, 3], [4, 0], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 1up 1right' do
        expect(white_knight.valid_move?([3, 3], [2, 4], gameboard)).to eql(false)
      end

      it 'returns false when piece moves 1left' do
        expect(white_knight.valid_move?([3, 3], [3, 2], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe Bishop do
  describe 'valid_move?' do
    let(:white_bishop) { Bishop.new('white')}
    let(:gameboard) { Gameboard.new }

    context 'checks for valid moves and returns a boolean. ' do
      it 'returns true when bishop moves diagonally down and right by 1' do
        expect(white_bishop.valid_move?([3, 3], [4, 4], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally down and left by 1' do
        expect(white_bishop.valid_move?([3, 3], [4, 2], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally up and right by 1' do
        expect(white_bishop.valid_move?([3, 3], [2, 4], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally up and left by 1' do
        expect(white_bishop.valid_move?([3, 3], [2, 2], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally down and right by more than 1' do
        expect(white_bishop.valid_move?([2, 2], [5, 5], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally up and left by more than 1' do
        expect(white_bishop.valid_move?([5, 7], [2, 4], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally down and left by more than 1' do
        expect(white_bishop.valid_move?([2, 4], [5, 1], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally down and right by 1' do
        expect(white_bishop.valid_move?([3, 3], [4, 4], gameboard)).to eql(true)
      end

      it 'returns true when bishop moves diagonally up and right by more than 1' do
        expect(white_bishop.valid_move?([5, 0], [2, 3], gameboard)).to eql(true)
      end

      it 'returns false when bishop moves laterally' do
        expect(white_bishop.valid_move?([3, 3], [3, 7], gameboard)).to eql(false)
      end

      it 'returns false when bishop moves vertically' do
        expect(white_bishop.valid_move?([3, 3], [5, 3], gameboard)).to eql(false)
      end

      it 'returns false when bishop moves in a fashion that is not exactly diagonal' do
        expect(white_bishop.valid_move?([2, 2], [4, 5], gameboard)).to eql(false)
      end

      it 'returns false when bishop moves in a fashion that is not exactly diagonal' do
        expect(white_bishop.valid_move?([4, 0], [2, 6], gameboard)).to eql(false)
      end

      it 'returns false when bishop tries to move through a friendly piece' do
        expect(white_bishop.valid_move?([7, 2], [4, 5], gameboard)).to eql(false)
      end

      it 'returns false when bishop tries to move through an enemy piece' do
        gameboard.board = [[' ', Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', Pawn.new('white'), ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('black'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(white_bishop.valid_move?([7, 2], [3, 6], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe Queen do
  describe 'valid_move?' do
    let(:white_queen) { Queen.new('white')}
    let(:gameboard) { Gameboard.new }

    context 'checks for valid moves and returns a boolean. ' do
      it 'returns true when queen moves diagonally down and right by 1' do
        expect(white_queen.valid_move?([3, 3], [4, 4], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally down and left by 1' do
        expect(white_queen.valid_move?([3, 3], [4, 2], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally up and right by 1' do
        expect(white_queen.valid_move?([3, 3], [2, 4], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally up and left by 1' do
        expect(white_queen.valid_move?([3, 3], [2, 2], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally down and right by more than 1' do
        expect(white_queen.valid_move?([2, 2], [5, 5], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally up and left by more than 1' do
        expect(white_queen.valid_move?([5, 7], [2, 4], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally down and left by more than 1' do
        expect(white_queen.valid_move?([2, 4], [5, 1], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally down and right by 1' do
        expect(white_queen.valid_move?([3, 3], [4, 4], gameboard)).to eql(true)
      end

      it 'returns true when queen moves diagonally up and right by more than 1' do
        expect(white_queen.valid_move?([5, 0], [2, 3], gameboard)).to eql(true)
      end

      it 'returns true when queen moves 1 space vertically' do
        expect(white_queen.valid_move?([1, 1], [2, 1], gameboard)).to eql(true)
      end

      it 'returns true when queen moves more than 1 space vertically' do
        expect(white_queen.valid_move?([1, 3], [4, 3], gameboard)).to eql(true)
      end

      it 'returns true when queen moves 1 space laterally' do
        expect(white_queen.valid_move?([3, 2], [3, 3], gameboard)).to eql(true)
      end

      it 'returns true when queen moves more than 1 space laterally' do
        expect(white_queen.valid_move?([2, 0], [2, 5], gameboard)).to eql(true)
      end

      it 'returns false when queen moves in a fashion that is not allowed' do
        expect(white_queen.valid_move?([2, 2], [4, 5], gameboard)).to eql(false)
      end

      it 'returns false when queen moves in a fashion that is not allowed' do
        expect(white_queen.valid_move?([4, 0], [2, 6], gameboard)).to eql(false)
      end

      it 'returns false when queen tries to move through a friendly piece' do
        expect(white_queen.valid_move?([7, 2], [4, 5], gameboard)).to eql(false)
      end

      it 'returns false when queen tries to move through an enemy piece diagonally' do
        gameboard.board = [[' ', Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', Pawn.new('white'), ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('black'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(white_queen.valid_move?([7, 2], [3, 6], gameboard)).to eql(false)
      end

      it 'returns false when queen tries to move through a piece on the board laterally' do
        expect(white_queen.valid_move?([0, 0], [0, 4], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe King do
  describe 'valid_move?' do
    let(:black_king) { King.new('black') }
    let(:gameboard) {Gameboard.new }

    context 'checks for valid moves and returns a boolean. ' do
      it 'returns true when King moves one space up' do
        expect(black_king.valid_move?([3, 3], [2, 3], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space down' do
        expect(black_king.valid_move?([3, 3], [4, 3], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space left' do
        expect(black_king.valid_move?([3, 3], [3, 2], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space right' do
        expect(black_king.valid_move?([3, 3], [3, 4], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space diagonally up and left' do
        expect(black_king.valid_move?([3, 3], [2, 2], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space diagonally up and right' do
        expect(black_king.valid_move?([3, 3], [2, 4], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space diagonally down and left' do
        expect(black_king.valid_move?([3, 3], [4, 2], gameboard)).to eql(true)
      end

      it 'returns true when King moves one space diagonally down and right' do
        expect(black_king.valid_move?([3, 3], [4, 4], gameboard)).to eql(true)
      end

      it 'returns false when King tries to move by 2 spaces' do
        expect(black_king.valid_move?([2, 2], [2, 4], gameboard)).to eql(false)
      end

      it 'returns false when King tries to move by more than 2 spaces' do
        expect(black_king.valid_move?([2, 2], [5, 5], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe Gameplay do
  describe '#move_input' do
    let(:game) { Gameplay.new }
    let(:io1) { StringIO.new }
    let(:io2) { StringIO.new }
    let(:player) { Player.new(1, 'white') }

    context 'Checks for valid moves and returns [[start], [stop]] once one is found' do

      before do
        allow($stdout).to receive(:puts)
        io1.puts '4'
        io1.puts '0'
        io1.puts '1'
        io1.puts '2'
        io1.rewind
      end

      it 'returns correct start stop values when user input is all acceptable' do
        $stdin = io1
        expect(game.move_input(player)).to eql([[4, 0], [1, 2]])
      end

      before do 
        allow($stdout).to receive(:puts)
        io2.puts 'r'
        io2.puts '5'
        io2.puts '9'
        io2.puts ']'
        io2.puts '2'
        io2.puts '4'
        io2.puts '.'
        io2.puts '-4'
        io2.puts '2'
        io2.rewind
      end

      it 'rejects unacceptable values and returns correct start stop values' do
        $stdin = io2
        expect(game.move_input(player)).to eql([[5, 2], [4, 2]])
      end
    end
  end
end

RSpec.describe Player do
  describe '#own_piece?' do
    let(:player1) { Player.new(1, 'white') }
    let(:player2) { Player.new(2, 'black') }
    let(:board) { Gameboard.new }

    context 'returns a boolean depending on whether or not the input space contains a piece belonging to the player' do
      it 'returns true when space contains a white piece which belongs to player one' do
        expect(player1.own_piece?([7, 0], board)).to eql(true)
      end

      it 'returns false when space contains a black piece which does not belong to player one' do
        expect(player1.own_piece?([0, 0], board)).to eql(false)
      end

      it 'returns false when space contains no piece' do
        expect(player1.own_piece?([4, 0], board)).to eql(false)
      end

      it 'returns true when space contains a black piece which belongs to player two' do
        expect(player2.own_piece?([0, 0], board)).to eql(true)
      end

      it 'returns false when space contains a white piece which does not belong to player two' do
        expect(player2.own_piece?([7, 0], board)).to eql(false)
      end

      it 'returns false when space contains no piece' do
        expect(player2.own_piece?([4, 0], board)).to eql(false)
      end
    end
  end
end

RSpec.describe Gameboard do
  describe '#space_occupied?' do
    let(:board) { Gameboard.new }

    context 'returns a boolean depending on if input space is occupied or not' do
      it 'returns false when space is empty' do
        expect(board.space_occupied?([4, 0])).to eql(false)
      end

      it 'returns true when space is occupied' do
        expect(board.space_occupied?([0, 0])).to eql(true)
      end
    end
  end

  describe '#check?' do 
    let(:board) { Gameboard.new }

    context 'returns a boolean depending on if the King piece is in check' do
      it 'returns true when the black King is in check from a rook' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(true)
      end

      it 'returns true when the black King is in check from a bishop' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', Bishop.new('white'), ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), ' ', Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(true)
      end

      it 'returns true when the black King is in check from a knight' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', Knight.new('white'), ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), ' ', Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(true)
      end

      it 'returns true when the black King is in check from a Queen' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', Queen.new('white')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(true)
      end

      it 'returns true when the black King is in check from a pawn' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('white'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(true)
      end

      it 'returns false when the black King is not in danger' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(false)
      end

      it 'returns false when the black King is not in danger' do
        board.board = [[Rook.new('black'), ' ', Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [Pawn.new('black'), ' ', Knight.new('black'), ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('black')).to eql(false)
      end

      it 'returns true when the white King is in check from a rook' do
        board.board = [[' ', Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('white'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('black'), ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('white')).to eql(true)
      end

      it 'returns true when the white King is in check from a knight' do
        board.board = [[Rook.new('black'), ' ', Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('white'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', Knight.new('black'), ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('white')).to eql(true)
      end

      it 'returns true when the white King is in check from a bishop' do
        board.board = [[Rook.new('black'), Knight.new('black'), ' ', Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('white'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Bishop.new('black'), ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('white')).to eql(true)
      end

      it 'returns true when the white King is in check from a Queen' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), ' ', King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('white'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Queen.new('black'), ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('white')).to eql(true)
      end

      it 'returns true when the white King is in check from a pawn' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('white'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('black'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.check?('white')).to eql(true)
      end
    end
  end

  describe '#checkmate?' do 
    let(:board) { Gameboard.new }

    context 'returns a boolean depending on if the King piece is in checkmate' do

      it 'returns false on brand new board' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(false)
      end

      it 'returns true when the black King is in checkmate from a singular piece' do
        board.board = [[' ', Knight.new('black'), Bishop.new('black'), Rook.new('black'), King.new('black'), Rook.new('black'), Bishop.new('black'), ' '], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(true)
      end

      it 'returns true when the black King is in checkmate from a two pieces' do
        board.board = [[Knight.new('black'), Rook.new('black'), ' ', Pawn.new('black'), King.new('black'), Rook.new('black'), ' ', ' '], 
        [Pawn.new('black'), Pawn.new('black'), ' ', ' ', ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', Bishop.new('white'), ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), ' ', Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(true)
      end

      it 'returns true when the black King is in checkmate from a three pieces' do
        board.board = [[Knight.new('black'), Rook.new('black'), ' ', ' ', King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'),  Knight.new('white'), Pawn.new('black'), ' ', ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', Bishop.new('white'), ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), ' ', Queen.new('white'), King.new('white'), Bishop.new('white'), ' ', Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(true)
      end

      it 'returns true when the black King is in checkmate from a three pieces (in a different location)' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), ' ', Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Rook.new('white'), ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', King.new('black'), ' ', ' ', Queen.new('white')], 
        [' ', ' ', ' ', Pawn.new('white'), ' ', ' ', ' ', Rook.new('white')], 
        [' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), ' ']]
        expect(board.checkmate?('black', [4, 4])).to eql(true)
      end

      it 'returns false when the black King is only in check, not checkmate' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), ' ', ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('black'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(false)
      end

      it 'returns false when the black King is only in check, not checkmate (case2)' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), ' ', Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Bishop.new('white'), ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), ' ', Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(false)
      end

      it 'returns false when King can eliminate threat to move out of check' do
        board.board = [[Rook.new('black'), Knight.new('black'), Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('white'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(false)
      end

      it 'returns true when white King is in checkmate as well' do
        board.board = [[Rook.new('black'), Knight.new('black'), ' ', Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', Bishop.new('black'), ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), ' ', Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('white', [7, 4])).to eql(true)
      end

      it 'returns false when another piece can eliminate threat in order to move King out of danger' do
        board.board = [[Rook.new('black'), ' ', Bishop.new('black'), Queen.new('black'), King.new('black'), Bishop.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', Bishop.new('white'), ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', Knight.new('black'), ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), ' ', Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(false)
      end

      it 'returns false when a piece can intercept a vertical threat to king (from rook)' do
        board.board = [[' ', Knight.new('black'), Bishop.new('black'), Pawn.new('black'), King.new('black'), Pawn.new('black'), Knight.new('black'), Rook.new('black')], 
        [Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [Rook.new('black'), ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Rook.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [' ', Knight.new('white'), Bishop.new('white'), Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [0, 4])).to eql(false)
      end

      it 'returns false when a piece can intercept a horizontal threat to king (from queen)' do
        board.board = [[' ', ' ', Bishop.new('black'), Pawn.new('black'), ' ', Pawn.new('black'), Knight.new('black'), Rook.new('black')], 
        [' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', Rook.new('black'), Knight.new('black'), Pawn.new('black')], 
        [Queen.new('white'), ' ', ' ', ' ', ' ', ' ', ' ', King.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), Bishop.new('white'), ' ', King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [3, 7])).to eql(false)
      end

      it 'returns false when a piece can intercept a diagonal threat to king (from bishop)' do
        board.board = [[Rook.new('black'), ' ', Bishop.new('black'), Queen.new('black'), ' ', ' ', Knight.new('black'), Rook.new('black')], 
        [' ', Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black'), Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', Bishop.new('black'), Knight.new('black'), King.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', Pawn.new('black')], 
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '], 
        [' ', ' ', ' ', ' ', Bishop.new('white'), ' ', ' ', ' '], 
        [Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white'), Pawn.new('white')], 
        [Rook.new('white'), Knight.new('white'), ' ', Queen.new('white'), King.new('white'), Bishop.new('white'), Knight.new('white'), Rook.new('white')]]
        expect(board.checkmate?('black', [2, 7])).to eql(false)
      end
    end
  end
end
