# frozen_string_literal: true

require_relative './sector'
require_relative './utilities'

class Galaxy
  extend Utilities

  attr_reader :map

  DEFAULT_WIDTH = 8
  DEFAULT_HEIGHT = 8

  def initialize
    @map = []
    @width = DEFAULT_WIDTH
    @height = DEFAULT_HEIGHT

    @total_klingons = 0
    @total_starbases = 0
    @total_stars = 0

    seed_galaxy
  end

  private

  def seed_galaxy
    @map = @height.times.collect do |r|
      @width.times.collect do |c|
        sector = Sector.new
        @total_klingons += sector.klingons
        @total_starbases += sector.starbase
        @total_stars += sector.stars
      end
    end
  end
end
