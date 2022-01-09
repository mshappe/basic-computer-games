# frozen_string_literal: true

require 'spec_helper'
require_relative '../app/ship_systems'

RSpec.describe ShipSystems do
  describe 'initialize' do
    subject { ShipSystems.new }

    it 'sets up a fully functional ship' do
      subject.status.each do |system, damage|
        expect(damage).to be_zero
      end
    end
  end
end
