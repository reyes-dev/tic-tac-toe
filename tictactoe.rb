#Order of Gameplay
#1. Display round, gameboard, and score
#2. Ask for input 1-9
#3. After it's entered, replace the given number in the array with X or O
#4. Check for victory by consecutive X's/O's, if not decided yet, continue looping
#5. If victory or tie, add a point to winner and instantiate a new Game object

#Methods to check gameboard for matching combo of three X's/O's
module Checkable
  def check(arr)
    arr.any? && arr.flatten.all?(@turn)
  end

  def check_rows
    @turn_check_array = @gameboard.select { |arr| arr.all?(@turn) }
    check(@turn_check_array)
  end

  def check_first_column
    @gameboard.each_index { |idx| @turn_check_array.push(@gameboard[idx].first) }
    check(@turn_check_array)
  end

  def check_middle_column
    clear_turn_check_array
    @gameboard.each_index { |idx| @turn_check_array.push(@gameboard[idx][1]) }
    check(@turn_check_array)
  end

  def check_last_column
    clear_turn_check_array
    @gameboard.each_index { |idx| @turn_check_array.push(@gameboard[idx].last) }
    check(@turn_check_array)
  end

  def check_first_diagonal
    clear_turn_check_array
    @gameboard.each_index { |idx| @turn_check_array.push(@gameboard[idx][idx]) }
    check(@turn_check_array)
  end

  def check_second_diagonal
    clear_turn_check_array
    @gameboard.each_index { |idx| @turn_check_array.push(@gameboard[idx].reverse[idx]) }
    check(@turn_check_array)
  end

  def clear_turn_check_array
    @turn_check_array = []
  end

  def check_all
    @game_over = [check_rows, check_first_column, 
      check_middle_column, check_last_column, 
      check_first_diagonal, check_second_diagonal].any?
  end
end
#Keeps track, displays and increments the score/rounds
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

  def increment_score_and_round
    @@round += 1
    case @turn
    when 'X' then @@player_X_wins += 1
    when 'O' then @@player_O_wins += 1
    else @@ties += 1
    end
  end
end
#Creates gameboard array and displays it
class GameBoard < GameScore
  attr_accessor :gameboard, :turn_check_array

  def initialize
    @gameboard = [
    [1,2,3], 
    [4,5,6], 
    [7,8,9]
    ]
    @turn_check_array = []
  end

  def display_board
    puts "#{@gameboard[0].join(' | ')}\n#{@gameboard[1].join(' | ')}\n#{@gameboard[2].join(' | ')}"
  end

  def display_all
    GameScore.display_round
    GameScore.display_score
    self.display_board
  end
end
# Takes user input, decides if player 'X' or 'O' turn, changes turn every play
# Updates gameboard array '1-9' blank slots with 'X' or 'O'
class GamePlay < GameBoard
  attr_accessor :choice, :players_turn, :turn, :game_over, :checks

  def initialize
    super
    @players_turn = true
    @game_over = false
    @choice = ''
  end

  def get_choice
    loop do 
      puts "Pick a spot between 1-9"
      @choice = gets.chomp
      break if @gameboard.flatten.one?(@choice.to_i) && @choice.match?(/[1-9]/)
    end
  end

  def whose_turn
    @players_turn ? @turn = 'X' : @turn = 'O'
  end

  def change_turn
    @players_turn ? @players_turn = false : @players_turn = true
  end

  def replace_blank
    @gameboard.each_with_index do |row, row_index|
      row.each_with_index do |num, column_index|
        if @gameboard[row_index][column_index] == @choice.to_i
          @gameboard[row_index][column_index] = @turn
        end
      end
    end
  end
end
# Loops game until a victor emerges or gameboard is full
# Takes input on whether to play a round or quit
class Game < GamePlay
  include Checkable
  attr_accessor :total_plays, :start

  def initialize
    super
    @total_plays = 0
  end

  def play
    until game_over || @total_plays >= 9
      self.display_all
      self.whose_turn
      self.get_choice
      self.replace_blank
      self.check_all
      self.change_turn unless game_over
      self.total_plays += 1
    end
    @turn = 'tie' if @total_plays >= 9
    self.increment_score_and_round
    self.display_all
  end

  def keep_playing
  loop do
      puts "Play a round? (Any input/No)"
      @start = gets.chomp.downcase
      break if @start == 'no'
      Game.new.play
    end
  end
end
#Starts the game
Game.new.keep_playing