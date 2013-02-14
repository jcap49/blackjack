class AbstractPlayer

	attr_accessor :hand

	def initialize
		@hand = []
	end


	def busted?
		if hand_value() > 21
			puts "Sorry, you've busted."
		else 
			puts "You're good to go"
		end
	end

	def hand_value
		hand.values.inject(0) {|sum, x| sum + x[1]}
	end

end

class Player < AbstractPlayer

end

class Dealer < AbstractPlayer

	def must_stay?
		hand_value >= 17
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
