#Use Rubocop after the logic is complete to tidy up
#Order of Gameplay
#1. Display round, gameboard, and score
#2. Display who's turn it is (X or O)
#3. Ask for input 1-9
#4. After it's entered, replace the given number in the array with X or O
#5. Check for victory, if not decided yet, continue

#Module that checks rows, columns and diagonals for consecutive X's/O's
#and stores a boolean true/false 
module CheckConsecutive
  def check(arr)
    arr.any? && arr.flatten.all?(@turn)
  end

  def check_rows
    @test_array = @gameboard.select { |arr| arr.all?(@turn)}
    check(@test_array)
  end

  def check_first_column
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx].first)}
    check(@test_array)
  end

  def check_middle_column
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx][1])}
    check(@test_array)
  end

  def check_last_column
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx].last)}
    check(@test_array)
  end

  def check_first_diagonal
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx][idx])}
    check(@test_array)
  end

  def check_second_diagonal
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx].reverse[idx])}
    check(@test_array)
  end
end



#Keep track of scores and rounds
class GameScore
  @@round = 1
  @@player_X_wins = 0
  @@player_O_wins = 0
  @@ties = 0

  def self.display_round
    puts "ROUND: #{@@round}"
  end

  def self.display_score
    puts "Player X Wins: #{@@player_X_wins} | Ties: #{@@ties} | Player O Wins: #{@@player_O_wins}"
  end

  def self.increase_score_X
    @@player_X_wins += 1
  end

  def self.increase_score_O
    @@player_O_wins += 1
  end

  def self.increase_ties
    @@ties += 1
  end

  def self.increase_round
    @@round += 1
  end
end
#Display the board nicely
class GameBoard < GameScore
  def initialize
    @gameboard = [
    [1,2,3], 
    [4,5,6], 
    [7,8,9]
    ]
    @test_array = []
  end

  def display_board
    puts "#{@gameboard[0].join(' | ')}\n#{@gameboard[1].join(' | ')}\n#{@gameboard[2].join(' | ')}"
  end
end
#Get a number 1-9
#Replace equivalent number in gameboard array with X or O
#check win condition
#While loop that keeps the game running and resets when a win/tie condition is met
class GamePlay < GameBoard
  attr_accessor :choice, :players_turn, :turn, :game_over

  def initialize
    super
    @players_turn = true
    @game_over = false
  end
  
  def get_choice
      puts "Pick a spot between 1-9"
      @choice = gets.chomp.to_i
  end

  def whose_turn?
    @players_turn ? @turn = 'X' : @turn = 'O'
  end

  def change_turn
    @players_turn ? @players_turn = false : @players_turn = true
  end

  def replace_blank
    @gameboard.each_with_index do |row, row_index|
      row.each_with_index do |num, column_index|
        if @gameboard[row_index][column_index] == @choice
          @gameboard[row_index][column_index] = @turn
        end
      end
    end
  end
end

#Instantiate a game object to start
#Calls methods up the chain needed to start the game
class Game < GamePlay
  include CheckConsecutive
  #Just change to initialize? so that making a new game object sets the whole avalanche off
  def initialize
    super
  end

  def check_win
  end
end

new_game = Game.new

# while !game_over do
#   GameScore.display_round
#   GameScore.display_score
# my_game.display_board
# my_game.get_choice
# my_game.whose_turn?
# my_game.replace_blank
# my_game.display_board
# my_game.change_turn
# end