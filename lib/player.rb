require './deck'

class AbstractPlayer

	attr_accessor :hand

	def initialize
		@hand = []
	end

	# define the value of player's hand 
	def hand_value
		hand.collect{|pair| pair[1]}.collect(&:to_i).inject(:+)
	end

	# define when a hand busts
	def player_busted?
		hand_value > 21
	end

	def blackjack?
		# TODO refactor so that blackjack is only 21 from the first 2 cards
		hand_value[0,1] == 21
	end

end

class Player < AbstractPlayer
end

class Dealer < AbstractPlayer

	def must_stay?
		hand_value.between?(17, 21)
	end

end
