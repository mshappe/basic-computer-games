# frozen_string_literal: true

class Timekeeper
  attr_reader :beginning, :now, :duration, :galaxy

  def initialize(galaxy)
    @galaxy = galaxy
    @beginning = (rand * 20 + 20).to_i * 100 # T0
    @now = @beginning # T
    @duration = 25 + (rand * 10).to_i # T9
    if @duration < galaxy.total_klingons
      @duration = galaxy.total_klingons + 1
    end
  end

  def end
    beginning + duration
  end

  def tick(delta_t)
    @now += delta_t
  end
end
