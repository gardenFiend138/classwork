require_relative "Tile"

class Board

  def self.from_file(file)
    arr = File.readlines(file).map(&:chomp)

    grid = arr.map do |row|
      row.split("").map do |value|
        num = value.to_i
        num != 0 ? Tile.new(num, true) : Tile.new(num)
      end
    end

    Board.new(grid)
  end

  def initialize(grid)
    @grid = grid
  end

end
