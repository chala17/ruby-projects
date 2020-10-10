# frozen-string-literal: true

require './lib/connect_four.rb'
require 'stringio'

RSpec.describe Player do
  describe '#make_a_move' do

    let(:io) { StringIO.new }
    let(:player) { Player.new(1, 'X') }
    let(:board) { Board.new }

    before do
      allow($stdout).to receive(:puts)
      io.puts '3'
      io.rewind
    end

    it 'gets user input and pushes it to proper index in board array' do
      $stdin = io
      expect { player.make_a_move(board) }.to change{ board.spaces[3] }.from([]).to(['X'])
      $stdin = STDIN
    end
  end
end

RSpec.describe Board do
  describe '#vertical?' do
    
    let(:player) { Player.new(1, 'X') }
    let(:board) { Board.new }

    context 'checking for a win vertically (within an array)' do
      
      xit 'returns true when player makes a winning move' do
        board.spaces[0].push('X')
        board.spaces[0].push('X')
        board.spaces[0].push('X')
        expect(board.vertical(player, 0)).to eql(true)
      end

      xit 'returns false when players move does not cause them to win' do
        expect(board.vertical(player, 3)).to eql(false)
      end
    end
  end

  describe '#horizontal' do
    
    let(:player) { Player.new(1, 'X') }
    let(:board) { Board.new }

    context 'checking for a win horizontally (across arrays)' do
      
      xit 'returns true when player makes a winning move' do
        board.spaces[0].push('X')
        board.spaces[1].push('X')
        board.spaces[2].push('X')
        expect(board.horizontal(player, 3)).to eql(true)
      end

      xit 'returns false when players move does not cause them to win' do
        expect(board.horizontal(player, 0)).to eql(false)
      end
    end
  end

  describe '#diagonal' do
    
    let(:player) { Player.new(1, 'X') }
    let(:board) { Board.new }

    context 'checking for a win diagonally' do
      
      xit 'returns true when player makes a winning move' do
        board.spaces[0].push('X')
        board.spaces[1].push('O')
        board.spaces[1].push('X')
        board.spaces[2].push('O')
        board.spaces[2].push('O')
        board.spaces[2].push('X')
        board.spaces[3].push('O')
        board.spaces[3].push('O')
        board.spaces[3].push('O')
        expect(board.diagonal(player, 3)).to eql(true)
      end

      xit 'returns false when player does not make a winning move' do
        expect(board.diagonal(player, 4)).to eql(false)
      end
    end
  end

  describe '#display_board' do
    
    let(:board) { Board.new }

    context 'verifying that the gameboard prints out correctly' do
      
      xit 'is capable of printing out an empty gameboard' do
        expect{ board.display_board }.to output(" ___________________
|___|___|___|___|___|
|___|___|___|___|___|
|___|___|___|___|___|
|___|___|___|___|___|
|___|___|___|___|___|
|___|___|___|___|___|").to_stdout
      end

      xit 'is capable of printing out a gameboard with spaces taken' do
        board.spaces[0].push('X')
        board.spaces[1].push('X')
        board.spaces[2].push('X')
        board.spaces[3].push('O')
        board.spaces[3].push('O')
        board.spaces[3].push('O')
        expect{ board.display_board }.to output(" ___________________
|___|___|___|___|___|
|___|___|___|___|___|
|___|___|___|___|___|
|___|___|___|_O_|___|
|___|___|___|_O_|___|
|_X_|_X_|_X_|_O_|___|").to_stdout
      end
    end
  end
end