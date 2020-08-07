class TicTacToe

  WIN_COMBINATIONS = [    #here is a class constant set equal to a nested array filled with the index values for the various winning combinations possible in Tic Tac Toe. We know this from seeing TicTacToe::WIN_COMBINATIONS in the test suite 
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

def initialize        # when a new game is started (new instance of TicTacToe initialized) the instance MUST set the starting state of the board (an array with 9 " " empty strings, within an instance vairable named @board)
  @board = Array.new(9, " ")      # In other words, your #initialize method sets a @board variable equal to a new, empty array that represents the game board.
end

def display_board    # this method prints the current board representation based on the @board instance variable. Basically now whatever value we input for @board (our move) is assigned to the appropriate space on the board  
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(user_input)   #method that passes a string user input (1, 5, ect), and returns the corresponding index of the @board array 
  user_input.to_i - 1     #  sends the user input to the appropriate space on the board. Remember arrays go from 0-8, the game goes from 1-9
end

def move(index, current_player = "X")   #method that takes in two arguments of this index in the @board array that the player chooses (aka the spot on the board) and also the player's token, which DEFAULTS TO 'X'
  @board[index] = current_player
end

def position_taken?(index)    #evaluates the users desired move (@board) against the TicTacToe board (checking the index values using [index] ) to see if it is or isn't occupied (using the .nil?) assert_operator
   # ( if the two values on either side of the two pipes || each result to true, uses == to see if this operation is equals to an open position on the board (" "), or if it contains an "X" or "O"
  !(@board[index].nil? || @board[index] == " ")
     # If the position is free, the method should return false (false is if the position is not taken), otherwise true 
end

def valid_move?(index)  # checks to see if the move is within the paramaters of the game, aka being entered in as 1 - 9, which is represented in the index as 0 - 8 
  index.between?(0,8) && !position_taken?(index)
      # it returns true if the move is valid, and false or nil if not (valid if it's present on the game board, and position is not already filled with a token)
end

def turn_count     #returns the number of turns that have been played based on each iteration of the @board variable, sets turn to start at 0 for start of game, runs it through the index of the iteration, checks if a turn did actually happen by running it through the strings that are put out on the board ( X and O ), and adds one to the turn counter, then returns the turn
  turn = 0
  @board.each do |index|
    if index == "X" || index == "O"
      turn += 1
    end
  end
  return turn
end

def current_player
  #if the turn count is an even number, that means O just went, so the next/current player is X
  num_turns = turn_count
  if num_turns % 2 == 0
    player = "X"
  else
    player = "O"
  end
  return player
end

def turn
  puts "Please choose a number 1-9:"  #asks user's input 
  user_input = gets.chomp   #recieves user input from above method 
  index = input_to_index(user_input)  # tranlates (converts) that input to an index value 
  if valid_move?(index)     #checks if the move (index) is valid 
    player_token = current_player    #if it's valid, sends it to the move method, and then starts the display board method 
    move(index, player_token)
    display_board
  else
    turn    # if it's not valid, asks for turn again
  end
end

def won?
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]
         # returns false/nil if there's no win combo on the board, if there is a win it returns winning combo indexes as an array  
    position_1 = @board[index_0]
    position_2 = @board[index_1]
    position_3 = @board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?
  @board.all? {|index| index == "X" || index == "O"}
end

def draw?
  if !won? && full?
    return true
  else
    return false
  end
end

def over?
  if won? || draw?
    return true
  else
    return false
  end
end

def winner
  index = []
  index = won?
  if index == false
    return nil
  else
    if @board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play
  until over? == true #until the game is over
    turn   #take turns 
  end

  if won?   #if the game was won 
    puts "Congratulations #{winner}!"    #Congratulate the winner 
  elsif draw?    #else if the game was a draw 
    puts "Cat's Game!"     #then tell the players it ended in a draw 
  end
end

end