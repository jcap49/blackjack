module	
	def deal_player_cards
		2.times { @player.hand << @deck.deal }
		print "You're holding: "
		@player.hand.each { |card_face, card_value| print card_face + " " }		
	end

	def deal_dealer_cards
		2.times { @dealer.hand << @deck.deal }
	end

end