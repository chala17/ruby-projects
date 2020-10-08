# spec/tic_tac_toe_spec.rb

require './lib/tic_tac_toe'
require 'stringio'

RSpec.describe Player do
  describe '#winner?' do
    it 'returns true when board reads XXX across top row' do
      player = Player.new(1, 'X', [0,1,2])
      expect(player.winner?).to eql(true)
    end

    it 'returns true when board reads OOO across top row' do
      player = Player.new(1, 'O', [0,1,2])
      expect(player.winner?).to eql(true)
    end

    it 'returns true when board reads XXX down a column' do
      player = Player.new(1, 'X', [0,3,6])
      expect(player.winner?).to eql(true)
    end

    it 'returns true when board reads XXX diagonally' do
      player = Player.new(1, 'X', [0,4,8])
      expect(player.winner?).to eql(true)
    end

    it "returns false when board doesn't have a winning combination" do
      player = Player.new(1, 'X', [0,2,3,4,7])
      expect(player.winner?).to eql(false)
    end
  end
end

RSpec.describe Board do
  describe '#display_board' do

    let(:board) {Board.new(Array.new(9, ' '))}

    it "prints out a blank board if argument is 'gameplay'" do
      expect{ board.display_board('gameplay') }.to output("   |   |   
___|___|___
   |   |   
___|___|___
   |   |   
   |   |   \n").to_stdout
    end

    it "prints out a board with spaces numbered if argument is 'spaces'" do
      expect{ board.display_board('spaces') }.to output(" 0 | 1 | 2 
___|___|___
 3 | 4 | 5 
___|___|___
 6 | 7 | 8 
   |   |   \n").to_stdout
    end
  end


  describe '#space_taken' do

    let(:io) { StringIO.new }
    let(:board) {Board.new(Array.new(9, ' '))}

    before do
      allow($stdout).to receive(:puts)
      io.puts '0'
      io.rewind
    end

    it 'returns true if space is not taken' do
      $stdin = io
      expect(board.space_taken?(2)).to eql(true)
      $stdin = STDIN
    end

    it 'returns false if space is taken' do
      $stdin = io
      board.spaces[2] = 'X'
      expect(board.space_taken?(2)).to eql(false)
      $stdin = STDIN
    end
  end
end



RSpec.describe 'display_winner' do
  it 'displays correct message when there is not a winner' do
    expect { display_winner(false) }.to output("Cats game! Nobody won :(\n").to_stdout
  end
end

RSpec.describe 'display_winner' do
  it 'displays correct message when there is a winner' do
    player = Player.new(1, 'X', [0,1,2])
    expect { display_winner(player) }.to output("Player1 you won! Congrats!\n").to_stdout
  end
end

RSpec.describe 'initialize_gameboard' do
  it 'returns an empty gameboard, ready to begin play' do
    expect(initialize_gameboard).to be_instance_of(Board)
  end
end

RSpec.describe 'gameplay' do

  let(:io) { StringIO.new }

  before do
    allow($stdout).to receive(:puts)
    io.puts "0\n"
    io.puts "1\n" 
    io.puts "2\n"
    io.puts "3\n"
    io.puts "4\n"
    io.puts "5\n"
    io.puts "6\n"
    io.rewind
  end

  it 'returns correct winner of won game' do
    player1 = Player.new(1, 'X', [])
    player2 = Player.new(2, 'O', [])
    gameboard = Board.new(Array.new(9, ' '))
    $stdin = io
    expect(gameplay(player1, player2, gameboard)).to eql(player1)
    $stdin = STDIN
  end
end

RSpec.describe 'gameplay' do

  let(:io) { StringIO.new }

  before do
    allow($stdout).to receive(:puts)
    io.puts "0\n"
    io.puts "1\n" 
    io.puts "2\n"
    io.puts "3\n"
    io.puts "5\n"
    io.puts "4\n"
    io.puts "7\n"
    io.puts "8\n"
    io.puts "6\n"
    io.rewind
  end

  it 'returns false if cats game' do
    player1 = Player.new(1, 'X', [])
    player2 = Player.new(2, 'O', [])
    gameboard = Board.new(Array.new(9, ' '))
    $stdin = io
    expect(gameplay(player1, player2, gameboard)).to eql(false)
    $stdin = STDIN
  end
end

RSpec.describe 'play_again?' do

  let(:io) { StringIO.new }

  before do
    allow($stdout).to receive(:puts)
    io.puts "y"
    io.rewind
  end

  it 'returns true if input is y' do
    $stdin = io
    expect(play_again?).to eql(true)
    $stdin = STDIN
  end
end

RSpec.describe 'play_again?' do

  let(:io) { StringIO.new }

  before do
    allow($stdout).to receive(:puts)
    io.puts "n"
    io.rewind
  end

  it 'returns false if input is n' do
    $stdin = io
    expect(play_again?).to eql(false)
    $stdin = STDIN
  end
end

RSpec.describe 'play_again?' do

  let(:io) { StringIO.new }

  before do
    allow($stdout).to receive(:puts)
    io.puts 'r'
    io.puts 'q'
    io.puts '7'
    io.puts 'n'
    io.rewind
  end

  it 'continues to prompt for user input until acceptable input is entered' do
    $stdin = io
    expect(play_again?).to eql(false)
    $stdin = STDIN
  end
end

RSpec.describe 'initialize_players' do

  let(:io) { StringIO.new }

  before do
    allow($stdout).to receive(:puts)
    io.puts 'X'
    io.rewind
  end

  it 'returns instances of player class with correct symbol' do
    $stdin = io
    expected_array = [instance_of(Player), instance_of(Player)]
    expect(initialize_players).to match_array(expected_array)
  end
end