class Card

  attr_reader :value, :face_up

  # Read more about the trailing colon method for defining default values

  def initialize(value, face_up: false)
    @value = value
    @face_up = face_up
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  # I wasn't sure what this method was supposed to do at first, but its
  # job is to return the value of the card as a string. Pretty straightforward.

  def to_s
    @face_up ? value.to_s : " "
  end
end
