module PlayAgain
  def play_again?
    print "Do you want to play again? (Y/N): "
    response = gets.chomp.downcase
      if response == "y"
        game = Game.new(@player_1, @player_2)
      elsif response == "n"
        win = true
      else
        puts "We need a Yes(Y) or No(N)!"
        self.win?
      end
  end
end
