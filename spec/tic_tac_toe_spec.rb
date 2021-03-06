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
    # Command Method
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
    # Looping Script Method
    # Test with @choice between 1 and 9
    # Test with invalid input, then a valid input
    subject(:choice_game) { described_class.new }

    context 'When @choice is between 1 and 9' do
      before do
        valid_input = '3'
        allow(choice_game).to receive(:gets).and_return(valid_input)
      end

      it 'breaks the loop' do
        expect(choice_game.get_choice).to be_nil
      end
    end

    context 'When @choice is invalid' do
      before do
        invalid_input = '10'
        valid_input = '3'
        allow(choice_game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'loops once' do
        message = "Pick a spot between 1-9"
        expect(choice_game).to receive(:puts).with(message).twice
        expect(choice_game.get_choice).to be_nil
      end
    end
  end

  describe '#whose_turn' do
    subject(:choice_game) { described_class.new }

    context 'When @players_turn is true' do
      it "Assigns 'X' to @turn" do
        choice_game.players_turn = true
        expect{ choice_game.whose_turn }.to change { choice_game.turn }.to('X')
      end
    end

    context 'When @players_turn is false' do
      it "Assigns 'O' to @turn" do
        choice_game.players_turn = false
        expect{ choice_game.whose_turn }.to change { choice_game.turn }.to('O')
      end
    end
  end

  describe '#change_turn' do
    subject(:change_game) { described_class.new }

    context 'When @players_turn is true' do
      it 'Assigns false to @players_turn' do
        change_game.players_turn = true
        expect{ change_game.change_turn }.to change { change_game.players_turn }.to(false)
      end
    end

    context 'When @players_turn is false' do
      it 'Assigns true to @players_turn' do
        change_game.players_turn = false
        expect{ change_game.change_turn }.to change { change_game.players_turn }.to(true)
      end
    end
  end

  describe '#replace_blank' do
    subject(:replace_game) { described_class.new }

    context "When @choice is 3 and @turn is 'X'" do
      it "Assigns 'X' to that @gameboard spot" do
        replace_game.turn = 'X'
        replace_game.choice = '3'
        expect { replace_game.replace_blank }.to change { replace_game.gameboard[0][2] }.to('X')
      end
    end

    context "When @choice is 10 and @turn is 'X'" do
      it 'Returns nil' do
        replace_game.turn = 'X'
        replace_game.choice = '10'
        allow(replace_game).to receive(:replace_blank).and_return(nil)
        expect(replace_game.replace_blank).to be_nil
      end
    end
  end
end

describe Game do

  describe '#check' do
    subject(:check_game) { described_class.new }

    context 'When arr is all equal to @turn' do
      it 'Returns true' do
        check_game.turn = 'X'
        arr = ['X', 'X', 'X']
        true_check = check_game.check(arr)
        expect(true_check).to be true
      end
    end

    context 'When arr has different elements' do
      it 'Returns false' do
        check_game.turn = 'X'
        arr = ['X', 'O', 'X']
        false_check = check_game.check(arr)
        expect(false_check).to be false
      end
    end

    context 'When arr is empty' do
      it 'Returns false' do
        check_game.turn = 'X'
        arr = []
        empty_check = check_game.check(arr)
        expect(empty_check).to be false
      end
    end
  end

  describe '#check_rows' do
    subject(:rows_game) { described_class.new }

    context 'When a row in @gameboard all equal @turn' do
      it 'Stores that array in @turn_check_array' do
        rows_game.turn = 'X'
        rows_game.gameboard = [
          ['X','X','X'], 
          [4,5,6], 
          [7,8,9]
          ]
          rows_game.check_rows
          arr = rows_game.turn_check_array.flatten
          expect(arr).to all( be == 'X')
      end
    end

    context 'When a row in @gameboard is unequal' do
      it 'Does not store anything in @turn_check_array' do
        rows_game.turn = 'X'
        rows_game.gameboard = [
          ['X','O','X'], 
          [4,5,6], 
          [7,8,9]
          ]
          rows_game.check_rows
          arr = rows_game.turn_check_array.flatten
          expect(arr).to be_empty
      end
    end
  end

  describe '#check_first_column' do
    subject(:first_column_game) { described_class.new }

    context 'When check_first_column is called' do
      it 'Stores the first index of each @gameboard array in @turn_check_array' do
        first_column_game.check_first_column
        turn_arr = first_column_game.turn_check_array
        arr = [1, 4, 7]
        expect(turn_arr).to eq(arr)
      end
    end
  end

  describe '#check_middle_column' do
    subject(:middle_column_game) { described_class.new }

    context 'When check_middle_column is called' do
      it 'Stores the second index of each @gameboard array in @turn_check_array' do
        middle_column_game.check_middle_column
        turn_arr = middle_column_game.turn_check_array
        arr = [2, 5, 8]
        expect(turn_arr).to eq(arr)
      end
    end
  end

  describe '#check_last_column' do
    subject(:last_column_game) { described_class.new }

    context 'When check_last_column is called' do
      it 'Stores the third index of each @gameboard array in @turn_check_array' do
        last_column_game.check_last_column
        turn_arr = last_column_game.turn_check_array
        arr = [3, 6, 9]
        expect(turn_arr).to eq(arr)
      end
    end
    
  end

  describe '#check_first_diagonal' do
    subject(:first_diag_game) { described_class.new }

    context 'When check_first_diagonal is called' do
      it 'Stores a diagonal from @gameboard in to @turn_check_array' do
        first_diag_game.check_first_diagonal
        turn_arr = first_diag_game.turn_check_array
        arr = [1, 5, 9]
        expect(turn_arr).to eq(arr)
      end
    end
  end

  describe '#check_second_diagonal' do
    subject(:second_diag_game) { described_class.new }

    context 'When check_second_diagonal is called' do
      it 'Stores a reverse diagonal from @gameboard in to @turn_check_array' do
        second_diag_game.check_second_diagonal
        turn_arr = second_diag_game.turn_check_array
        arr = [3, 5, 7]
        expect(turn_arr).to eq(arr)
      end
    end
  end

  describe '#clear_turn_check_array' do
    subject(:clear_game) { described_class.new }

    context 'When clear_turn_check_array is called on a full array' do
      it 'Assigns @turn_check_array an empty array' do
        clear_game.turn_check_array = ['X', 'X', 'X']
        clear_game.clear_turn_check_array
        new_arr = clear_game.turn_check_array
        expect(new_arr).to be_empty
      end
    end
  end

  describe '#check_all' do
    subject(:check_all_game) { described_class.new }

    context 'When check_all is called before the game is over' do
      it 'Sets @game_over as false' do
        check_all_game.check_all
        results = check_all_game.game_over
        expect(results).to be false
      end
    end

    context 'When check_all is called on a game with win condition met' do
      it 'Sets @game_over to true' do
        check_all_game.turn = 'X'
        check_all_game.gameboard = [
          ['X',2,3], 
          [4,'X',6], 
          [7,8,'X']
          ]
        check_all_game.check_all
        results = check_all_game.game_over
        expect(results).to be true
      end
    end
  end

  describe '#play' do
    subject(:play_game) { described_class.new }

    context 'When @game_over is true' do
      it 'Exits the loop' do
        play_game.game_over = true
        expect(play_game.play).to be_nil
      end
    end

    context 'When @total_plays is equal to 9' do
      it 'Exits the loop' do
        play_game.total_plays = 9
        expect(play_game.play).to be_nil
      end
    end

    context 'When @total_plays is equal to 10' do
      it 'Exits the loop' do
        play_game.total_plays = 10
        expect(play_game.play).to be_nil
      end
    end
  end
end