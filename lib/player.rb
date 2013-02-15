require './deck'

class AbstractPlayer

	attr_accessor :hand

	def initialize
		@hand = []
	end

	# define the value of player's hand 
	def hand_value
		hand.collect{|pair| pair[1]}
		hand.collect{|pair| pair[1]}.collect(&:to_i)
		hand.collect{|pair| pair[1]}.collect(&:to_i).inject(:+)
	end

	# define when a hand busts
	def player_busted?
		if hand_value > 21
			puts "Sorry - you busted."
			return game_over
		else
		end
	end

end

class Player < AbstractPlayer

end

class Dealer < AbstractPlayer

	def must_stay?
		if hand_value == (17..21)
			puts "Alright, the dealer stays."
		else
		end
	end

	def dealer_busted?
		if hand_value > 21
			puts "The dealer busted."
			return game_won
		else
		end
	end	

	def hit(hand_value)
		if hand_value <= 16
			deal
		elsif hand_value >= 17
			stay
		else hand_value == 21
			game_won
		end
	end

end
