
class ComputerPlayer

  def initialize
    @known_cards = {}
    @matched_cards = []
    @first_guess = true
  end

  def update(dimension)
    @board = Array.new(dimension) { Array.new(dimension) }
  end

  def get_input
    available_moves

    if @first_guess && match_exist?
      @first_guess = false
      known_matches.last
    elsif match_exist?
      @first_guess = true
      known_matches.first
    else
      # This ternary reads as: "If true, set @first_guess to be false;
      # if false, set @first_guess to be true."
      @first_guess = @first_guess ? false : true
      @available_moves.sample
    end
  end

  def known_matches
    known_matches = @known_cards.select do |_, v|
      @known_cards.values.count(v) == 2
    end
    @matches = known_matches.keys
  end

  def match_exist?
    @known_cards.each_value do |v|
      return true if @known_cards.values.count(v) == 2
    end
    false
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
  end

  def receive_match(pos1, pos2)
    @matched_cards << pos1
    @matched_cards << pos2
    @known_cards.delete(pos1)
    @known_cards.delete(pos2)
  end

  def available_moves
    @available_moves = []
    @board.length.times do |x|
      @board[0].length.times do |y|
        @available_moves << [x, y]
      end
    end

    @available_moves -= @known_cards.keys
    @available_moves -= @matched_cards
  end

  # Duck typing methods so that both the computer and human classes can
  # interact with the game independent of the game knowing which class
  # the current player is an instance of.

  def alert_invalid_input() end

  def prompt() end
end
