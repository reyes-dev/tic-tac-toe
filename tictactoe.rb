#Use Rubocop after the logic is complete to tidy up
#Display the board nicely
#Instantiate a new game object with a fresh board
class GameBoard
  def initialize
    @gameboard = [
    [1,2,3], 
    [4,5,6], 
    [7,8,9]
    ]
  end

  def display_board
    puts "#{@gameboard[0].join(' | ')}\n#{@gameboard[1].join(' | ')}\n#{@gameboard[2].join(' | ')}"
  end
end

first_game = GameBoard.new
first_game.display_board

#Gameplay Logic to replace number in array with 'X' or 'O'
# arr = [[1,2,3], [4,5,6], [7,8,9]]
# x = 0
# while x < 9 do
#   choice = gets.to_i

  # arr.each_with_index do |row, row_index|
  #   row.each_with_index do |num, column_index|
  #     puts "Row: #{row_index} Column: #{column_index} = #{num}"
  #     if arr[row_index][column_index] == choice
  #       arr[row_index][column_index] = 'X'
  #     end
  #   end
  # end
  
#   puts "#{arr[0].join(' | ')}\n#{arr[1].join(' | ')}\n#{arr[2].join(' | ')}"
#   x += 1
# end
