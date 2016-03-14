require_relative 'board'
require_relative 'players'
require_relative 'play_again'

class Game
  include PlayAgain
  attr_reader :player_1,
              :player_2,
              :round

  def initialize(player_1 = nil, player_2 = nil)
    # create_new_or_take_input()
    player_1.nil? ? @player_1 = nil : @player_1 = player_1
    player_2.nil? ? @player_2 = nil : @player_2 = player_2

    @board = Board.new
    self.print_board
    self.user_names
    self.play
  end

  def print_board
    puts @board.print
  end

  def user_names
    if @player_1.nil?
      print "Player 1: What is your name? "
        response = gets.chomp.to_s
        @player_1 = Player.new(response)
      print "Player 2: What is your name? "
        response = gets.chomp.to_s
        if response == @player_1.name
          print "You need to have a unique name!"
          self.user_names
        else
          @player_2 = Player.new(response)
        end
    else
      puts "\n** Let's play another rousing match of Connect 4! **\n\n---\n\n"
    end
  end

  def play
    @round = Round.new(@player_1, @player_2)

    while self.win? == false
      @round.move
      @round.user_selection
        if @board.column_full(@round.current_players_move) == false
          @board.piece_placement(@round)
        else
          puts "Column is full!"
          until !@board.column_full(@round.current_players_move) == true
            @round.user_selection
          end
          @board.piece_placement(@round)
        end
      puts @board.print
      @board.win(@round.current_players_move)
    end
  end

  def win?
    win = false
    if @round.current_players_move.nil?
      win = false
    elsif @board.win(@round.current_players_move) == "tie"
      win = true
      puts "It's a tie!"
      self.play_again?
    elsif @board.win(@round.current_players_move) == true
        win = true
        if @round.current_players_turn == @player_1.symbol
          puts "#{@player_1.name} has won!"
        else
          puts "#{@player_2.name} has won!"
        end
        self.play_again?
    end
    win
  end

end
