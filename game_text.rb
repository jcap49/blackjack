module GameText 
	def get_user_input
		gets.chomp()
	end

	def get_user_name
		name = get_user_input
		if name == "" 
			puts "Great to have you Anonymous Player."
		else
			puts "Great to have you #{self.name}!"
		end
	end
	
	def welcome_text
		puts "Welcome to the Elepath Casino! Please type your name:"
	end

	def game_begins_text
		puts "We're now going to begin the game."
		puts ""
		puts ""
		puts "The cards are being dealt..."	
	end

	def move_question_text
		puts ""
		puts ""
		puts "Would you like to hit or stay? Press 'h' for hit or 's' for stay."
	end

	def hit_or_stay_text
		puts "Please respond with either 'h' for hit or 's' for stay."
	end

	def turn_over_text
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

	def player_busted_text
		puts "You busted. Game over - would you like to play again?"
	end

	def player_wins_text
		puts "Congratulations #{self.name}! Looks like you won!"
	end

	def dealer_wins_text
		puts "Heavy scheiss man - looks like the dealer won this time."
	end

	def game_split_text
		puts "Boom - we're split."
	end
end
