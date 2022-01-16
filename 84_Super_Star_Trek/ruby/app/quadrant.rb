require_relative './galaxy'
require_relative './utilities'
require_relative './villain'

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

  TOKENS = {
    hero: '<*>',
    villain: '+K+',
    starbase: '>!<',
    star: ' * ',
    space: '   '
  }

  attr_reader :num_klingons, :num_stars,
              :klingons, :starbase, :stars,
              :sectors, :galaxy, :x, :y

  # Override `random` when you need to test with a specific value
  # Any lamba will do, so, -> { 0.99 } would ensure max villains and a starbase
  def initialize(galaxy, x:, y:, random: -> { rand })
    @galaxy = galaxy
    @x = x
    @y = y

    @sectors = Array.new(8) { Array.new(8) { TOKENS[:space] }}

    @num_klingons = case random.call
    when 0.98..1.00
      3
    when 0.96..0.98
      2
    when 0.80..0.96
      1
    else
      0
    end

    @has_starbase = random.call > 0.96

    @num_stars = special_random(one_based: true)

    # For this port, we follow the same rules that the
    # BASIC code did. This means each quadrant is governed
    # by Schroedinger, and no objects are actually placed
    # until the hero enters the quadrant.
    reset_quadrant

    galaxy.increment(klingons: num_klingons,
                     starbases: starbase? ? 1 : 0,
                     stars: num_stars)
  end

  def starbase?
    @has_starbase
  end

  def reset_quadrant
    @klingons = []
    @starbase = nil
    @stars = []
  end

  def tweak(add_klingons: 0, add_starbase: false)
    @num_klingons += add_klingons
    @has_starbase = add_starbase
    galaxy.increment klingons: add_klingons,
                     starbases: add_starbase ? 1 : 0
  end

  def hero
    galaxy.hero
  end

  def name
    # Reminder: coordinates are 1-based, arrays are 0 based
    name = NAMES[x <= 4 ? y - 1 : y + 7]
    subname = SUBNAMES[x <= 4 ? x - 1 : x - 5]

    "#{name} #{subname}"
  end

  def find_space # sub 8590
    sx = -1
    sy = -1
    loop do
      sx = special_random(one_based: true)
      sy = special_random(one_based: true)
      break if sector(x: sx, y: sy) == TOKENS[:space]
    end

    Location.new quadrant: { x: x, y: y },
                 sector: { x: sx, y: sy }
  end

  def place_entity(type, x:, y:) # sub 8670
    raise ArgumentError, "Invalid type #{type}" if !TOKENS.keys.include? type
    sectors[y - 1][x - 1] = TOKENS[type]
  end

  def sector(x:, y:)
    sectors[y - 1][x - 1]
  end

  def hero_arrives
    announce_arrival
    place_hero
    place_villains
    place_starbase
    place_stars
  end

  def announce_arrival
    hero = galaxy.hero
    if hero.timekeeper.now == hero.timekeeper.beginning
      puts <<-FIRST
Your mission begins with your starship located
in the galactic quadrant #{name}.

FIRST
    else
      puts <<-ARRIVAL
Now entering #{name} quadrant . . .

ARRIVAL
    end

    if num_klingons > 0
      puts "COMBAT AREA     CONDITION RED"
      puts "   SHIELDS DANGEROUSLY LOW" if hero.shields <= 200
    end
  end

  def place_hero # 1680
    # Even stars move for our hero. Hero comes first, so
    # we go based on nav or random-initial coords
    place_entity(:hero, x: hero.location.sector.x, y: hero.location.sector.y)
  end

  def place_villains
    return unless num_klingons > 0
    @klingons = Array.new(num_klingons) do
      loc = find_space
      place_entity(:villain, x: loc.sector.x, y: loc.sector.y)
      Villain.new(loc)
    end
  end

  def place_starbase
    return unless starbase?
    @starbase = find_space
    place_entity(:starbase, x: starbase.sector.x, y: starbase.sector.y)
  end

  def place_stars
    @stars = Array.new(num_stars) do
      loc = find_space
      place_entity(:star, x: loc.sector.x, y: loc.sector.y)
      loc
    end
  end

  def to_i
    num_klingons * 100 + starbase? ? 10 : 0 + num_stars
  end

  def to_s
    "%03d" % to_i
  end
end
