require './deck'
require './player'

class Game
	attr_accessor :name

	def play!
		# Instantiate a deck
		@deck = Deck.new

		# Shuffle the deck
		@deck.shuffle

		# Instantiate a dealer and a player
		@dealer = Dealer.new
		@player = Player.new
		
		puts "Welcome to the Elepath Casino! Please type your name:"

		# Get the user's name
		self.name = get_user_input
		if self.name == "" 
			puts "Great to have you Anonymous Player."
		else
			puts "Great to have you #{self.name}!"
		end

		puts "We're now going to begin the game."

		puts ""
		puts ""
		puts "The cards are being dealt..."

		# Deal cards
		2.times { @player.hand << @deck.deal }
		print "You're holding: "
		@player.hand.each { |card_face, card_value| print card_face + " " }

		# Deal cards to the dealer
		2.times { @dealer.hand << @deck.deal }

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

		puts "Your hand is over. Dealer's turn!"
	end

	def run_dealer_loop
		begin
			puts " "
			puts "-- dealer is checking his cards --"
			puts " "

			unless @dealer.must_stay? || @dealer.player_busted?
				@dealer.hand << @deck.deal
			end

			
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

