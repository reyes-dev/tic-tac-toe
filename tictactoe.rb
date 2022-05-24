#Use Rubocop after the logic is complete to tidy up
#Add comments after completion
#get_choice should only take 1-9 as input and not move on until so
#Order of Gameplay
#1. Display round, gameboard, and score
#2. Display who's turn it is (X or O)
#3. Ask for input 1-9
#4. After it's entered, replace the given number in the array with X or O
#5. Check for victory, if not decided yet, continue
#6. If victory or tie, add a point to winner and instantiate a new Game object


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
    clear_test_array
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx][1])}
    check(@test_array)
  end

  def check_last_column
    clear_test_array
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx].last)}
    check(@test_array)
  end

  def check_first_diagonal
    clear_test_array
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx][idx])}
    check(@test_array)
  end

  def check_second_diagonal
    clear_test_array
    @gameboard.each_index {|idx| @test_array.push(@gameboard[idx].reverse[idx])}
    check(@test_array)
  end

  def clear_test_array
    @test_array = []
  end

  def check_all
    @game_over = [check_rows, check_first_column, check_middle_column, check_last_column, check_first_diagonal, check_second_diagonal].any?
  end
end

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
    when 'X'
      @@player_X_wins += 1
    when 'O'
      @@player_O_wins += 1
    else
      @@ties += 1
    end
  end
end

class GameBoard < GameScore

  attr_accessor :gameboard, :test_array

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

  def display_all
    GameScore.display_round
    GameScore.display_score
    self.display_board
  end
end

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
      break if @choice.match?(/[1-9]/)
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

class Game < GamePlay

  include CheckConsecutive

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

Game.new.keep_playing