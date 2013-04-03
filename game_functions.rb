require './player.rb'

module GameFunctions
	def deal_player_cards
		2.times { @player.hand << @deck.deal }
		print "You're holding: "
		@player.hand.each { |card_face, card_value| print card_face  }		
	end

	def deal_dealer_cards
		2.times { @dealer.hand << @deck.deal }
	end

	def run_player_loop
		player_stayed = false
		begin
			move_question_text
			response = get_user_input
			if response.capitalize == "H"
				@player.hand << @deck.deal
				print "You're now holding: "
				@player.hand.each { |card_face, card_value| print card_face  }
			elsif response.capitalize == "S"
				player_stayed = true
			else
				hit_or_stay_text
				run_player_loop
			end

		end until player_stayed || @player.player_busted?

		if @player.player_busted?
			player_busted_text
		end
		turn_over_text
	end

	def run_dealer_loop
		begin
			dealer_card_check
			@dealer.hand << @deck.deal
		end until @dealer.must_stay? || @dealer.player_busted?
		@dealer.dealers_cards
	end

	def score_game
		check_busted
		check_blackjack
		hand_value_comparison
	end

	# used in game scoring
	def check_blackjack
		if @player.blackjack?
			puts "Blackjack!"
			return
		elsif @dealer.blackjack?
			puts "Dealer blackjack!"
			return
		end
	end

	# used in game scoring
	def check_busted
		if @player.player_busted?
			puts "You busted."
			return
		elsif @dealer.player_busted?
			puts "The dealer busted."
			return
		end
	end

	def hand_value_comparison
		if @player.hand_value > @dealer.hand_value
			player_wins
		elsif @player.hand_value < @dealer.hand_value
			dealer_wins
		elsif @player.hand_value == @dealer.hand_value 
			game_split
		else
			puts "What next?"
		end
	end

	def play_again?
		result = get_user_input
		result.downcase == 'y'
	end
end
