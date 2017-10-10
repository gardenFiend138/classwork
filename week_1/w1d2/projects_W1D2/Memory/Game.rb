require_relative "Board"
require_relative "Card"
require_relative "HumanPlayer"
require_relative "ComputerPlayer"
class Game

  attr_reader :board, :player1

  # Update here for the human will tell the size of the grid;
  # Update for the computer will initialize a grid for the computer

  def initialize(player1, board = Board.new)
    @board = board
    @board.populate!
    @player1 = player1
    @previous_guess = nil
    @player1.update(board.grid.length)
  end

  def make_guess(pos)
    guessed_pos = board.reveal(pos)
    board.render

    if @previous_guess
      if board[@previous_guess].value != guessed_pos
        board[pos].hide
        board[@previous_guess].hide
      else
        player1.receive_match(pos, @previous_guess)
      end
    end

    @previous_guess ||= pos

    guessed_pos
  end

  def get_move(player)
    player.prompt
    pos = player.get_input

    until pos.all? { |num| ("0".."9").cover?(num) } &&
      valid_guess?(pos.map(&:to_i))
      player.alert_invalid_input
      pos = player.get_input
    end
    pos.map(&:to_i)
  end

  def valid_guess?(pos)
    if pos.any? { |el| el > board.grid.length - 1 } ||
      pos.length != 2 ||
      board[pos].face_up

      return false
    end
    true
  end

  def play
    until over?
      system("clear")
      board.render
      2.times do
        player1.prompt
        pos = player1.get_input
        value = make_guess(pos)
        player1.receive_revealed_card(pos, value)
      end

      sleep(1)

      @previous_guess = nil
    end
    puts "You win!"
  end

  def over?
    board.won?
  end


end

if __FILE__ == $PROGRAM_NAME
  player = ComputerPlayer.new
  Game.new(player).play
end
