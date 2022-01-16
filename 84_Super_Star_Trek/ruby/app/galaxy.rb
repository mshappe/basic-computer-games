# frozen_string_literal: true

require_relative './hero'
require_relative './quadrant'
require_relative './utilities'

class Galaxy
  extend Utilities

  attr_reader :quadrants,
              :hero,
              :total_klingons, :total_starbases, :total_stars

  DEFAULT_WIDTH = 8
  DEFAULT_HEIGHT = 8

  def initialize
    @width = DEFAULT_WIDTH
    @height = DEFAULT_HEIGHT

    @total_klingons = 0
    @total_starbases = 0
    @total_stars = 0

    @hero = Hero.new self
    @quadrants = seed_galaxy
    validate_galaxy
  end

  def map
    quadrants.each do |r|
      puts '-'*35
      puts  ": #{r.collect(&:to_s).join(':')} :"
    end
    puts '-'*35
  end

  def increment(klingons: 0, starbases: 0, stars: 0)
    @total_klingons += klingons
    @total_starbases += starbases
    @total_stars += stars
  end

  def quadrant(location)
    quadrants[location.quadrant.x - 1][location.quadrant.y - 1]
  end

  private

  def seed_galaxy
    Array.new(@height) do |r|
      Array.new(@width) do |c|
        Quadrant.new self, x: c + 1, y: r + 1
      end
    end
  end

  def validate_galaxy
    if total_starbases == 0
      start_quadrant = quadrant(hero.location)
      if start_quadrant.num_klingons < 2
        start_quadrant.tweak add_klingons: 1, add_starbases: 2
      else
        start_quadrant.tweak add_starbases: 1
      end

      hero.reset_start
    end
  end
end
