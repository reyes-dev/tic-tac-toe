# tic-tac-toe
This is a tic-tac-toe program that is playable in the command line.
The game board will look like this: 

1 | 2 | 3
---------
4 | 5 | 6
---------
7 | 8 | 9

Post-Game Record
-------------------------------------
X has #wins | # of Ties | O has #wins
-------------------------------------

After the fifth round the program can check rows, columns and crosses for all X's or O's.
The game continues until three simultaneous X's or O's occur. 
Then a score is tallied giving a win point to either player X or player O.
If the board is full with no victory, a tie is tallied.
After a game the post-game record should be displayed and board reset.
Typing 'exit' should leave the program.
Typing anything other than 1-9 should do nothing.
Once a 1-9 position has been changed into an 'X' or 'O' it should be unchangeable.

Think about how you would set up the different elements within the game. 
What should be a class, Instance variable, or Method? 
Don't share information between classes any more than you have to.

I could have a class Play, with two children that inherit from it, X and O. 
X and O could inherit a method from Play that creates an object X/O and puts it in the chosen 1-9 spot.
I was thinking of using an array for the game board, but is there a better way?