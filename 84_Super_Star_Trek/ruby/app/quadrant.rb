require_relative './utilities'

class Quadrant
  include Utilities

  NAMES = %w(
    Antares
    Rigel
    Procyon
    Vega
    Canopus
    Altair
    Sagittarius
    Pollux
    Sirius
    Deneb
    Capella
    Betelguese
    Aldebaran
    Regulus
    Arcturus
    Spica
  )

  SUBNAMES = %w(
    I
    II
    III
    IV
  )

  attr_reader :klingons, :starbases, :stars, :sectors, :galaxy, :x, :y

  def initialize(galaxy, x:, y:)
    @galaxy = galaxy
    @x = x
    @y = y

    @sectors = Array.new(8) { Array.new(8) }

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

    @starbases = if rand > 0.96
      1
    else
      0
    end

    @stars = special_random(one_based: true)
    galaxy.increment(klingons: klingons, starbases:starbases, stars: stars)
  end

  def tweak(add_klingons: 0, add_starbases: 0)
    @klingons += add_klingons
    @starbases += add_starbases
    galaxy.increment klingons: add_klingons, starbases: add_starbases
  end

  def name
    # Reminder: coordinates are 1-based, arrays are 0 based
    name = NAMES[x <= 4 ? y - 1 : y + 7]
    subname = SUBNAMES[x <= 4 ? x - 1 : x - 5]

    "#{name} #{subname}"
  end

  def to_i
    klingons * 100 + starbases * 10 + stars
  end

  def to_s
    "%03d" % to_i
  end
end
