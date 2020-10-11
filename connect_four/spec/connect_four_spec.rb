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
      io.puts '3'
      io.puts '4'
      io.rewind
    end

    it 'gets user input and pushes it to proper index in board array' do
      $stdin = io
      expect { player.make_a_move(board) }.to change{ board.spaces[2] }.from([]).to(['X'])
      $stdin = STDIN
    end

    it 'prompts for user input until acceptable input is entered' do
      $stdin = io
      board.spaces[2].push('X')
      board.spaces[2].push('X')
      board.spaces[2].push('X')
      board.spaces[2].push('X')
      board.spaces[2].push('X')
      board.spaces[2].push('X')
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
      
      it 'returns true when player makes a winning move' do
        board.spaces[0].push('X')
        board.spaces[0].push('X')
        board.spaces[0].push('X')
        board.spaces[0].push('X')
        expect(board.vertical?(player, 0)).to eql(true)
      end

      it 'returns false when players move does not cause them to win' do
        expect(board.vertical?(player, 3)).to eql(false)
      end
    end
  end

  describe '#horizontal' do
    
    let(:player) { Player.new(1, 'X') }
    let(:board) { Board.new }

    context 'checking for a win horizontally (across arrays)' do
      
      it 'returns true when player makes a winning move' do
        board.spaces[0].push('X')
        board.spaces[1].push('X')
        board.spaces[2].push('X')
        board.spaces[3].push('X')
        expect(board.horizontal?(player, 3)).to eql(true)
      end

      it 'returns false when players move does not cause them to win' do
        board.spaces[0].push('X')
        expect(board.horizontal?(player, 0)).to eql(false)
      end
    end
  end

  describe '#diagonal' do
    
    let(:player) { Player.new(1, 'X') }
    let(:board) { Board.new }

    context 'checking for a win diagonally' do
      
      it 'returns true when player makes a winning move' do
        board.spaces = [['X'], ['O','X'], ['O', 'O', 'X'], ['O', 'O', 'O', 'X'], [], []]
        expect(board.diagonal?(player, 3)).to eql(true)
      end

      it 'returns false when player does not make a winning move' do
        board.spaces[4].push('X')
        expect(board.diagonal?(player, 4)).to eql(false)
      end
    end
  end

  describe '#display_board' do
    
    let(:board) { Board.new }

    context 'verifying that the gameboard prints out correctly' do
      
      it 'is capable of printing out an empty gameboard' do
        expect{ board.display_board }.to output("|___|___|___|___|___|___|
|___|___|___|___|___|___|
|___|___|___|___|___|___|
|___|___|___|___|___|___|
|___|___|___|___|___|___|
|___|___|___|___|___|___|\n").to_stdout
      end

      it 'is capable of printing out a gameboard with spaces taken' do
        board.spaces[0].push('X')
        board.spaces[1].push('X')
        board.spaces[2].push('X')
        board.spaces[3].push('O')
        board.spaces[3].push('O')
        board.spaces[3].push('O')
        expect{ board.display_board }.to output("|___|___|___|___|___|___|
|___|___|___|___|___|___|
|___|___|___|___|___|___|
|___|___|___|_O_|___|___|
|___|___|___|_O_|___|___|
|_X_|_X_|_X_|_O_|___|___|\n").to_stdout
      end
    end
  end

  describe '#board_full?' do

    let(:board) { Board.new }

    context 'checks if board is full which would result in a Cats Game' do

      it 'returns false if board is not full' do
        expect(board.board_full?).to eql(false)
      end

      it 'returns true if board is completely full' do
        board.spaces = [['X', 'X', 'X', 'X', 'X', 'X'],
                        ['X', 'X', 'X', 'X', 'X', 'X'],
                        ['X', 'X', 'X', 'X', 'X', 'X'],
                        ['X', 'X', 'X', 'X', 'X', 'X'],
                        ['X', 'X', 'X', 'X', 'X', 'X'],
                        ['X', 'X', 'X', 'X', 'X', 'X']]
        expect(board.board_full?).to eql(true)
      end
    end
  end
end

RSpec.describe Gameplay do
  describe '#create_players' do

    let(:io) { StringIO.new }
    let(:gameplay) { Gameplay.new }

    before do
      allow($stdout).to receive(:puts)
      io.puts 'X'
      io.rewind 
    end

    it 'returns 2 instances of Player class' do
      $stdin = io
      expected_array = [instance_of(Player), instance_of(Player)]
      expect(gameplay.create_players).to match_array(expected_array)
      $stdin = STDIN
    end

    it 'returns player classes with expected attributes' do
      $stdin = io
      players = gameplay.create_players
      expect(players[0]).to have_attributes(:player => 1, :symbol => 'X')
      $stdin = STDIN
    end
  end

  describe '#play_again?' do

    let(:gameplay) { Gameplay.new }
    let(:io) { StringIO.new }
    let(:io2) { StringIO.new }
    let(:player) { Player.new(1, 'X')}

    before do
      allow($stdout).to receive(:puts)
      io.puts 'y'
      io2.puts 'n'
      io.rewind
      io2.rewind
    end

    context 'returns true or false to decide whether or not to start another game' do

      it 'returns true when player wants to play again' do
        $stdin = io
        expect(gameplay.play_again?(player)).to eql(true)
        $stdin = STDIN
      end

      it 'returns false when player does not want to play again' do
        $stdin = io2
        expect(gameplay.play_again?(player)).to eql(false)
        $stdin = STDIN
      end
    end
  end
end