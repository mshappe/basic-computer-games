require_relative './utilities'

class Sector
  extend Utilities

  attr_reader :klingons, :starbase, :stars

  def initialize
    @klingons = case rand
    when 0.98..1.00
      3
    when 0.96..0.98
      2
    when 0.80..0.96
      1
    else
      0
    end

    @starbase = if rand > 0.96
      1
    else
      0
    end

    @stars = Sector.special_random(one_based: true)
  end

  def to_i
    klingons * 100 + starbase * 10 + stars
  end
end
