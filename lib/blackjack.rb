require './deck'
require './player'

class Game
	attr_accessor :name

	def play!
		include './game_text'
		include './game_functions'

		@deck = Deck.new
		@deck.shuffle

		@dealer = Dealer.new
		@player = Player.new

		welcome_text
		get_user_name
		game_begins_text
		

		

		# Deal cards
		2.times { @player.hand << @deck.deal }
		print "You're holding: "
		@player.hand.each { |card_face, card_value| print card_face + " " }

		# Deal cards to the dealer
		

		puts ""
		puts ""

		# Now run a game loop for the player and dealer
		run_player_loop
		run_dealer_loop

		score_game

		puts "Want to play again? Type (Y)es or (N)o"

	end

	def play_again?
		result = get_user_input
		result.downcase == 'y'
	end

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

	def run_player_loop
		player_stayed = false
		begin
			puts ""
			puts ""
			puts "Would you like to hit or stay? Press 'h' for hit or 's' for stay."
			response = get_user_input

			puts "" 

			if response.capitalize == "H"
				@player.hand << @deck.deal
				print "You're now holding: "
				@player.hand.each { |card_face, card_value| print card_face + " " }
			elsif response.capitalize == "S"
				player_stayed = true
			else
				puts "Please respond with either 'h' for hit or 's' for stay."
				
			end

		end until player_stayed || @player.player_busted?

		if @player.player_busted?
			puts "You busted. Game over - would you like to play again?"
		end

		puts "Your hand is over. Dealer's turn!"
	end

	def run_dealer_loop
		begin
			puts " "
			puts "-- dealer is checking his cards --"
			puts " "

				
				@dealer.hand << @deck.deal
			
		end until @dealer.must_stay? || @dealer.player_busted?

		puts "Dealer's hand is over. They had:"
		puts @dealer.hand.collect{|c| c[1]}.join(' ')
		puts ""
	end

	def score_game
		# Check for blackjack
		if @player.blackjack?
			puts "Blackjack!"
			return
		elsif @dealer.blackjack?
			puts "Dealer blackjack!"
			return
		end

		# Check for busts
		if @player.player_busted?
			puts "You busted."
			return
		elsif @dealer.player_busted?
			puts "The dealer busted."
			return
		end

		# No blackjack or busts; score game
		if @player.hand_value > @dealer.hand_value
			puts "Congratulations #{self.name}! Looks like you won!"
		elsif @player.hand_value < @dealer.hand_value
			puts "Heavy scheiss man - looks like the dealer won this time."
		elsif @player.hand_value == @dealer.hand_value 
			puts "Boom - we're split."
		else
			puts "What next?"
		end
	end
end

begin
	game = Game.new
	game.play!
end while game.play_again?



Process.exit(1)

