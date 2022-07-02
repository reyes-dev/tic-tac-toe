require_relative '../tictactoe.rb'

# Write tests for your Tic Tac Toe project. In this situation, it’s not quite as simple as just coming up with inputs and making sure the method returns the correct thing. You’ll need to make sure the tests that determine victory or loss conditions are correctly assessed.
# Start by writing tests to make sure players win when they should, e.g. when the board reads X X X across the top row, your #game_over method (or its equivalent) should trigger.
# Test each of your critical methods to make sure they function properly and handle edge cases.
# Use mocks/doubles to isolate methods to make sure that they’re sending back the right outputs.

# What is the behavior I want out of my TTT?
# How do I test my win conditions?
# -- #check is used in each check method in the Check module
# So I want to test that first
# What is check supposed to do?
# I know check is called by other methods, so I can test if that's happening properly
# I think what check does is actually check if any array items are true or not
# Because if all array items are false (arr.any?) then it returns false, whereas
# if there's one true, it returns true. 
# So each checking method besides #check first stores a certain set of tiles in a certain direction (i.e. a first row, second column or zig-zag) 
# Then calls the check method on that new array which checks if the array is empty (for #check_rows) and if all of the tiles equal the current @turn 'X' or 'O' 
# -- #check_rows is special in that it checks each of the three arrays in @gameboard and stores a 'true' in @turn_check_array if any of the arrays all have the same @turn
# I can set up tests to check two types of array:
# 1. Arrays where all the elements are equal
# 2. Arrays where the elements are not equal
# I can check all classes from GameScore through, GameBoard, GamePlay, to Game
# I can set up all my barebones tests first, for all the methods worth testing
# I can commit after each class is set up
# Game inherits Checkable module so I can test that module under Game class
# Testing: When I pass in 'X', a method returns 'Y'
# Or: When a variable passes a condition 'X', returns 'Y'

describe GamePlay do
  describe '#increment_score_and_round' do
    # Test Round increment
    # Test player_X_wins increment
    # Test player_O_wins increment
    # Test ties increment
    subject(:increment_game) { described_class.new }

    context 'When @@Round is 1' do
      it 'Adds 1 to @@Round' do
        increment_game.increment_score_and_round
        expect(GameScore.class_variable_get(:@@round)).to eq(2)
      end
    end

    context "When @turn is 'X'" do
      it 'Adds 1 to @@player_X_wins' do
        increment_game.turn = 'X'
        increment_game.increment_score_and_round
        expect(GameScore.class_variable_get(:@@player_X_wins)).to eq(1)
      end
    end

    context "When @turn is 'O'" do
      it 'Adds 1 to @@player_O_wins' do
        increment_game.turn = 'O'
        increment_game.increment_score_and_round
        expect(GameScore.class_variable_get(:@@player_O_wins)).to eq(1)
      end
    end

    context "When @turn is 'tie'" do
      it 'Adds 1 to @@ties' do
        increment_game.turn = 'tie'
        increment_game.increment_score_and_round
        expect(GameScore.class_variable_get(:@@ties)).to eq(1)
      end
    end
  end

  describe '#get_choice' do
    
  end

  describe '#whose_turn' do
    
  end

  describe '#change_turn' do
    
  end

  describe '#replace_blank' do
    
  end
end

describe Game do
  describe '#play' do
    
  end

  describe '#keep_playing' do
    
  end

  describe '#check' do

  end

  describe '#check_rows' do
    
  end

  describe '#check_first_column' do
    
  end

  describe '#check_middle_column' do
    
  end

  describe '#check_last_column' do
    
  end

  describe '#check_first_diagonal' do
    
  end

  describe '#check_second_diagonal' do
    
  end

  describe '#clear_turn_check_array' do
    
  end

  describe '#check_all' do
    
  end
end