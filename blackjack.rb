require './deck'
require './player'
require './game_text'
require './game_functions'


class Game
	include GameText
	include GameFunctions
	attr_accessor :name

	def play!
		@deck = Deck.new
		@deck.shuffle

		@dealer = Dealer.new
		@player = Player.new

		welcome_text
		get_user_name
		game_begins_text

		deal_player_cards
		deal_dealer_cards
		
		run_player_loop
		run_dealer_loop

		score_game
	end
end

begin
	game = Game.new
	game.play!
end while game.play_again?

Process.exit(1)

