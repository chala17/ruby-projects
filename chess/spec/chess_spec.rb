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

    context 'checks for valid moves and returns a boolean' do
      it 'returns true when pawn moves by 1' do
        expect(black_pawn.valid_move?([1, 2], [2, 2], gameboard)).to eql(true)
      end

      it 'returns true when pawn moves by 2 on initial move' do
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

      xit 'returns true when pawn moves in an attacking fashion and captures a piece' do
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

      xit 'returns false when pawn moves diagonally and does not capture a piece' do
        expect(black_pawn.valid_move?([1, 5], [2, 6], gameboard)).to eql(false)
      end
    end
  end
end

RSpec.describe Rook do
  describe '#valid_move?' do
    let(:white_rook) { Rook.new('white') }
    let(:gameboard) { Gameboard.new }

    context 'checks for valid moves and returns a boolean' do
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

    context 'checks for valid moves and returns a boolean' do
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