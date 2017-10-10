class Game
  attr_reader :current_player, :previous_player, :fragment, :dictionary

  def initialize(player1, player2)
    @current_player, @previous_player = player1, player2
    @fragment = ""
    @dictionary = {}
    dict_arr = IO.readlines("Dictionary.txt")
    dict_arr.each_with_index do |word, idx|
      @dictionary[idx] = word.chomp
    end
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def over?
    @dictionary.value?(@fragment)
  end

  def input_valid?(chr)
    @dictionary.each_value do |v|
      return true if v[0..@fragment.length] == @fragment + chr
    end
    false
  end

  def update_fragment(chr)
    @fragment += chr
  end

  def update_dictionary
    @dictionary.delete_if do |k, v|
      v[0...@fragment.length] != @fragment
    end
  end


end
