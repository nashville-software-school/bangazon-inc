# Guessing Game

## A C# Exercise

Write a console program in C# that invites the user to guess a number.

The program should be written in increments. Each phase will add a little more complexity.

### Phase 1

The program should...

1. Display a message to the user asking them to guess the secret number.
1. Display a prompt for the user's guess.
1. Take the user's guess as input and save it as a variable.
1. Display the user's guess back to the screen.

### Phase 2

The program should be updated to...

1. Create a variable to contain the _secret number_. This number should be hard-coded for now. 42 is a nice number.
1. No longer display the user's guess. They know what they guessed, right?
1. Compare the user's guess with the secret number. Display a success message if the guess is correct, otherwise display a failure message.

### Phase 3

The program should be updated to...

1. Give the user four chances to guess the number.
1. Continue to display the success or failure messages as in **phase 2**

### Phase 4

The program should be updated to...

1. Display the number of the user's current guess in the prompt.
   For example, if the user has already guessed one time, the prommpt should say something like `Your guess (2)>`.
1. End the loop early if the user guesses the correct number.

### Phase 5

The program should be updated to...

1. Use a random number between 1 and 100 instead of a hard-coded number.
1. The prompt should display the number of guesses the user has left.

### Phase 6

The program should be updated to...

1. Inform the user if their guess was too high or too low, when they guess incorrectly.

### Phase 7

The program should be updated to...

1. Prompt the user for a difficulty level before they are prompted to guess the number.
1. The difficulty level should determine how many guesses the user gets.
   The difficulty levels should be:
   - Easy - this gives the user eight guesses.
   - Medium - this gives the user six guesses.
   - Hard - this gives the user four guesses.

### Phase 8

The program should be updated to...

1. Add a difficulty level of "Cheater" which will cause the program to continue prompting the user until they get the answer correct.
