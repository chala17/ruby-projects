# frozen-string-literal: true

require './players.rb'
require './gameboard.rb'
require './pieces.rb'

class Gameplay

  def valid_entry?(num)
    return false unless num.to_i.to_s == num

    return false unless num.to_i > -1 && num.to_i < 8
    true
  end

  def move_input
    start = []
    stop = []
    counter = 1
    while counter < 5
      entry = -1
      until valid_entry?(entry)
        puts "Please enter the #{counter.even? ? 'column' : 'row'} #{counter < 3 ? 
        'of the piece that you would like to move' : 'of the space you would like to move your piece to'}."
        entry = gets.chomp
        puts('That is not a valid entry') unless valid_entry?(entry)
      end
      counter < 3 ? start.push(entry.to_i) : stop.push(entry.to_i)
      counter += 1
    end
    return start, stop
  end
end

