# frozen_string_literal: true
require 'ostruct'
require_relative '../app/utilities'

class Location
  include Utilities

  attr_reader :quadrant, :sector

  def initialize(quadrant: nil, sector: nil)
    range_check(quadrant)
    range_check(sector)

    quadrant ||= {
      x: special_random(one_based: true),
      y: special_random(one_based: true)
    }

    sector ||= {
      x: special_random(one_based: true),
      y: special_random(one_based: true)
    }

    @quadrant = OpenStruct.new(quadrant)
    @sector = OpenStruct.new(sector)
  end

  protected

  def range_check(hash)
    return if hash.nil?
    if hash[:x] < 1 || hash[:y] > 8 ||
       hash[:y] < 1 || hash[:y] > 8
      raise(ArgumentError, "Coordinates must be between 1 and 8 inclusive")
    end
  end
end
