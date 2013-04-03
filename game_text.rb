module GameText 
	def welcome_text
		puts "Welcome to the Elepath Casino! Please type your name:"
	end

	def game_begins_text
		puts "We're now going to begin the game."
		puts ""
		puts ""
		puts "The cards are being dealt..."	
	end

	def move_question
		puts ""
		puts ""
		puts "Would you like to hit or stay? Press 'h' for hit or 's' for stay."
	end

	def turn_over
		puts "Your hand is over. Dealer's turn!"
	end

	def dealer_card_check
		puts " "
		puts "-- dealer is checking his cards --"
		puts " "
	end

	def play_again_text
		puts "Want to play again? Type (Y)es or (N)o"
	end

	def player_busted
		puts "You busted. Game over - would you like to play again?"
	end
end
