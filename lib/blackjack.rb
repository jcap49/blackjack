require './deck'
require './player'

# Instantiate a deck
@deck = Deck.new

# Shuffle the deck
@deck.shuffle

# Instantiate a dealer and a player
@dealer = Dealer.new
@player = Player.new



# define a "Game Over" message
def game_over
	puts "Game Over."
	Process.exit(1)
end

# define a "Game won" message
def game_won
	puts "Congratulations - looks like you won!"
	puts "Would you like to play again?"
	response = gets.chomp

	if response.capitalize == "Yes"
		game_prompt
	elsif response.capitalize == "No"
		puts "Sounds good - catch you later."
		Process.exit(1)
	else
		puts "Please respond with either a yes or a no."
	end
end

# define a "Blackjack" message
def blackjack
	@player.hand_value || @dealer.hand_value == 21
	puts "Oh shit - blackjack baby!"
end


# welcome message and prompt to begin game
def game_prompt
	puts "Welcome to the Elepath Casino - are you ready to play?"

	response = gets.chomp()
	puts ""
	puts ""

	if response.capitalize == "Yes"
		puts "Great, before we begin please tell me your name."

		name = gets.chomp()

		if name == "" 
			puts "Great to have you Anonymous Player."
		else
			puts ""
			puts ""
			puts "Great to have you #{name}!"
		end

	elsif response.capitalize == "No"
		puts "Sorry to hear that - come again soon."
		Process.exit(1)
	else
		puts "Please answer with a yes or a no."
		puts ""
		puts ""
		game_prompt
		
	end
end
game_prompt

# game begins 
puts ""
puts ""
puts "We're now going to begin the game."

puts ""
puts ""
puts "The cards are being dealt..."

puts ""
puts ""

# Deal cards to the player
2.times { @player.hand << @deck.deal }
print "You're holding: "
@player.hand.each { |card_face, card_value| print card_face + " " }

# Deal cards to the dealer
2.times { @dealer.hand << @deck.deal }



# Let the player play

	player_stayed = false
	begin
		puts ""
		puts ""
		puts "Would you like to hit or stay? Press 'h' for hit or 's' for stay."
		response = gets.chomp()

		puts "" 

		if response.capitalize == "H"
			@player.hand << @deck.deal
			print "You're now holding: "
			@player.hand.each { |card_face, card_value| print card_face + " " }

			unless @player.player_busted? 
				@player.hand << @deck.deal
			else
				game_over
			end

		elsif response.capitalize == "S"
			player_stayed = true
		else
			puts "Please respond with either 'h' for hit or 's' for stay."
			
		end

	end until player_stayed || @player.player_busted?



puts "Now the dealer's turn begins."


# Let the dealer play now that the player is finished

# dealer needs to "look" at cards then either hit or stay/reveal
begin
	puts " "
	puts "-- dealer is checking his cards --"

	puts " "

	unless @dealer.dealer_busted? || @dealer.must_stay?
		@dealer.hand << @deck.deal
	else
		game_won
	end
	
end until @dealer.dealer_busted? || @dealer.must_stay?

# Figure out who won
puts "Time to see who won the hand"
puts "Press [enter] to reveal your hand"
response = gets.chomp()
puts ""
@player.hand.each { |card_face, card_value| print card_face + " " }
puts ""
puts "And the dealer has: "
@dealer.hand.each { |card_face, card_value| print card_face + " " }

if @player.hand.to_i > @dealer.hand.to_i
	puts "Congratulations #{name}! Looks like you won!"
	game_won
elsif @player.hand.to_i < @dealer.hand.to_i
	puts "Heavy scheiss man - looks like I won this time."
	game_over
elsif @player.hand.to_i == @dealer.hand.to_i 
	puts "Boom - we're split."
	game_over
else
	"What next?"
end

		




