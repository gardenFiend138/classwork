class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def update(size)
    puts "Let's play a memory matching game! There are #{size * size} cards."
  end

  def prompt
    puts "Enter the coordinates for which card you want to reveal (ie. 0,1)."
  end

  def get_input
    gets.chomp.split(",")
  end

  def alert_invalid_input
    puts "Invalid guess. Please try again."
  end

  # Duck typing methods so that both the computer and human classes can
  # interact with the game independent of the game knowing which class
  # the current player is an instance of.

  def receive_revealed_card(pos, value) end

  def receive_match(pos1, pos2) end
end
