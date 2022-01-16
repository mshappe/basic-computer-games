# frozen_string_literal: true

require_relative './galaxy'
require_relative './location'
require_relative './ship_systems'
require_relative './timekeeper'
require_relative './utilities'

class Hero
  include Utilities

  attr_reader :energy, :torpedoes, :shields,
              :timekeeper, :location, :systems,
              :galaxy

  MAX_ENERGY = 3000
  MAX_TORPEDOES = 10

  def initialize(galaxy)
    @energy = MAX_ENERGY
    @shields = 0
    @torpedoes = MAX_TORPEDOES
    @timekeeper = Timekeeper.new galaxy
    @location = Location.new # TODO: collision check
    @systems = ShipSystems.new
    @galaxy = galaxy
  end

  def reset_start
    # new random quadrant, same sector
    @location = Location.new(sector: location.sector)
  end

  def orders
    to_be = galaxy.total_starbases == 1 ? 'is' : 'are'
    starbase_s = galaxy.total_starbases > 1 ? 'Starbase' : 'Starbases'
<<-ORDERS
Your orders are as follows:
    Destroy the #{galaxy.total_klingons} Klingon warships which have invaded
    the galaxy before they can attack Federation headquarters
    on Stardate #{timekeeper.end}. This gives you #{timekeeper.duration} days. There #{to_be} #{galaxy.total_starbases} #{starbase_s}
    in the galaxy for resupplying your ship.
ORDERS
  end
end
