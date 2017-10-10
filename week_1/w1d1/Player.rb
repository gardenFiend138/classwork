class Player
  attr_reader :name, :last_guess

  def initialize(name)
    @name = name
  end

  def guess
    print "Enter your guess: "
    @last_guess = gets.chomp
    alert_valid_guess?
  end

  def alert_valid_guess?
    if !@last_guess.length == 1 ||
      !("a".."z").to_a.include?(@last_guess.downcase)
      puts "That's not a valid guess. Please enter one letter."
      guess
    end
    @last_guess
  end

end
