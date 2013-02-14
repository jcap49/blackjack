require './deck'
require './player'

# Instantiate a deck
@deck = Deck.new

# Shuffle the deck
@deck.shuffle

# Instantiate a dealer and a player
@dealer = Dealer.new
@player = Player.new

# define the value of player's hand 
def player_hand_value
	@player.hand.collect{|pair| pair[1]}
	@player.hand.collect{|pair| pair[1]}.collect(&:to_i)
	@player.hand.collect{|pair| pair[1]}.collect(&:to_i).inject(:+)
end

# define the value of dealer's hand
def dealer_hand_value
	@dealer.hand.collect{|pair| pair[1]}
	@dealer.hand.collect{|pair| pair[1]}.collect(&:to_i)
	@dealer.hand.collect{|pair| pair[1]}.collect(&:to_i)
end

# define a busted player hand
def player_busted?
	if player_hand_value > 21
		puts "Sorry, you've busted."
		return game_over
	else 
	end
end

# define a busted dealer hand
def dealer_busted?
	if dealer_hand_value > 21
		puts "The dealer has busted."
		return game_won
	end
end

# define dealer must stay
def dealer_must_stay?
	hand_value.to_i >= 17
	puts "Alright, the dealer stays."
end


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
	hand_value == 21
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
def player_game_play
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

			unless busted? 
				player_game_play
			else
				game_over
			end

		elsif response.capitalize == "S"
			player_stayed = true
		else
			puts "Please respond with either 'h' for hit or 's' for stay."
			player_game_play
		end

	end until player_stayed || @player.hand.busted?
end
player_game_play

puts "Now the dealer's turn begins."


# Let the dealer play now that the player is finished

# dealer needs to "look" at cards then either hit or stay/reveal
begin
	puts " "
	puts "Hmmm let me see here..."
	1.times do @dealer.hand << @deck.deal 
	end
	@dealer.hand.inspect

end until @dealer.dealer_busted? || @dealer.dealer_must_stay?

# Figure out who won
puts "Time to see who won the hand"
puts "Press [enter] to reveal your hand"
response = gets.chomp()
puts ""
@player.hand.each { |card_face, card_value| print card_face + " " }
puts ""
puts "And I've got: "
@dealer.hand.each { |card_face, card_value| print card_face + " " }

if @player.hand.to_i > @dealer.hand.to_i
	puts "Congratulations #{name}! Looks like you won!"
elsif @player.hand.to_i < @dealer.hand.to_i
	puts "Heavy scheiss man - looks like I won this time."
elsif @player.hand.to_i == @dealer.hand.to_i 
	puts "Boom - we're split."
else
	"What next?"
end

		




