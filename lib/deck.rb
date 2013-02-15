class Deck

	CARDS = {"2" => "2", "3" => "3", "4" => "4", "5" => "5", 
		"6" => "6", "7" => "7", "8" => "8", "9" => "9", 
		"10" => "10", "J" => "10", "Q" => "10", "K" => "10", 
		"A" => "11"}

	def initialize
		@deck = Array.new
		4.times do |card|
			CARDS.each do |card|
				@deck.push (card)
			end
		end
	end

	def shuffle
		@deck.shuffle!
	end

	def deal
	 	@deck.shift
	end
end


