require_relative 'board'
require_relative 'validate_move'

class Round
  include ValidateMove
  attr_reader :player_1,
              :player_2,
              :current_players_turn,
              :current_players_move

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @current_players_move = nil
    @current_players_turn = nil
    self.sort
  end

  def sort
    player_symbols = ["X", "O"]
    player_symbols.shuffle!
    @player_1.symbol = player_symbols.pop
    @player_2.symbol = player_symbols.pop
  end

  def move
    if @current_players_turn.nil?
      if player_1.symbol == "X"
        @current_players_turn = player_1.symbol
      else
        @current_players_turn = player_2.symbol
      end
    else
      @current_players_turn == player_1.symbol ? @current_players_turn = player_2.symbol : @current_players_turn = player_1.symbol
    end
    @current_players_turn
  end

# this should just be one selection per turn, store the current turn and column selection in the instance state of the round
  def user_selection
    if @current_players_turn == @player_1.symbol
      print "#{@player_1.name} what column would you like to drop a piece in? (1-10): "
      @current_players_move = gets.chomp.to_i
      self.valid_move?
    else
      print "#{@player_2.name} what column would you like to drop a piece in? (1-10): "
      @current_players_move = gets.chomp.to_i
      self.valid_move?
    end
    @current_players_move
  end

end
