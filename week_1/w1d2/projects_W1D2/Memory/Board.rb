require_relative "Card"

class Board

  attr_accessor :grid

  def initialize(size = 4)
    @grid = Array.new(size) { Array.new(size) }
  end

  def count
    @grid.flatten.length
  end

  def deck
    deck = []
    (count / 2).times do |value|
      2.times { deck << Card.new(value) }
    end
    deck.shuffle
  end

  def populate!
    shuffled_deck = deck

    grid.each_with_index do |row, x|
      row.each_index do |y|
        grid[x][y] = shuffled_deck.pop
      end
    end
  end

  def render
    grid.each do |row|
      row.each do |card|
        print "[#{card}]"
      end
      puts ""
    end
  end

  # Passing our face_up card method as a proc

  def won?
    grid.flatten.all?(&:face_up)
  end

  def reveal(guessed_position)
    card = self[guessed_position]
    card.reveal unless card.face_up
    card.value
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, card)
    x, y = pos
    grid[x][y] = card
  end

end
