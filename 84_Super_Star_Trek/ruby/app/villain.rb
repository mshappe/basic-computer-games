# frozen_string_literal: true

class Villain
  attr_reader :location, :shields

  SHIELD_SEED = 200

  def initialize(location)
    @location = location
    @shields = SHIELD_SEED * (0.5 + rand)
  end
end
