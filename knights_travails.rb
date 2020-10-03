# frozen-string-literal: true

def valid_move?(move)
  return true if (move[0] > -1 && move[0] < 8) && (move[1] > -1 && move[1] < 8)

  false
end

def generate_moves(start)
  moves = []
  [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]].each do |move|
    move[0] += start[0]
    move[1] += start[1]
    moves.append(move)
  end
  moves.select { |move| valid_move?(move) }
end

def make_path_table(start, queue = [start], visited_array = [], path = [])
  return path if queue.empty?

  element = queue.shift
  visited_array << element
  temp_queue = generate_moves(element)
  temp_queue = temp_queue.select { |move| !visited_array.include?(move) && !queue.include?(move) }
  temp_queue.each { |move| queue << move }
  path << [element, temp_queue] unless temp_queue.empty?
  make_path_table(start, queue, visited_array, path)
  path
end

def quickest_route(start, finish, path = [finish])
  return "You're already there!" if start == finish

  path_table = make_path_table(start)
  until finish == start
    path_table.each do |index|
      next unless index[1].include?(finish)

      path.append(index[0])
      finish = index[0]
    end
  end
  path.reverse
end

def knight_moves(start, finish)
  path = quickest_route(start, finish)
  puts "You made it in #{path.length - 1} #{path.length - 1 == 1 ? 'move!' : 'moves!'} Here's your path:"
  path.each { |move| print "#{move}\n" }
end

knight_moves([7, 7], [0, 0])
