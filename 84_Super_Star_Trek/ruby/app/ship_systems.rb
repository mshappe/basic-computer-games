# frozen_string_literal: true

class ShipSystems
  SYSTEMS = {
    warp: 'Warp Engines',
    srs: 'Short Range Sensors',
    lrs: 'Long Range Sensors',
    phasers: 'Phaser Control',
    photons: 'Photon Tubes',
    dc: 'Damage Control',
    shields: 'Shield Control',
    library: 'Library-Computer'
  }

  attr_reader :status

  def initialize
    @status = {}

    SYSTEMS.keys.each do |system|
      @status[system] = 0
    end
  end
end
