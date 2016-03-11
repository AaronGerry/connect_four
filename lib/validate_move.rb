module ValidateMove
  def valid_move?
    move = false
    if @current_players_move >= 1 && @current_players_move <= 10
      move = true
    else
      puts "That's not a valid column!"
      self.user_selection
    end
  end
end
