# frozen_string_literal: true

require 'spec_helper'

require_relative '../app/location'
require_relative '../app/villain'

RSpec.describe Villain do
  describe 'initialize' do
    subject { described_class.new location }

    let(:location) { Location.new quadrant: { x: 4, y: 4},
                                  sector: { x: 2, y: 2 } }

    it 'should be ready for action' do
      expect(subject.location).not_to be_nil
      expect(subject.shields).to be > 0
    end
  end
end
