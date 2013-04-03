require './deck'

class AbstractPlayer

	attr_accessor :hand

	def initialize
		@hand = []
	end

	def hand_value
		hand.collect{|pair| pair[1]}.collect(&:to_i).inject(:+)
	end

	def player_busted?
		hand_value > 21
	end

	def blackjack?
		 if hand_value[0 + 1] == 21
		 	puts "Blackjack!"
		 else
		 	return
		 end
		end
	end

end

class Player < AbstractPlayer
end

class Dealer < AbstractPlayer
	
	def must_stay?
		hand_value.between?(17, 21)
	end

end
