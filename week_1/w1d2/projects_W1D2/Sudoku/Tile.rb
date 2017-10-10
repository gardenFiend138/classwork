class Tile
  attr_reader :value

  def initialize(value, given = false)
    @value = value
    @given = given
  end

  def value=(num)
    @value = num unless given
  end

  def to_s
    value.to_s
  end
end
