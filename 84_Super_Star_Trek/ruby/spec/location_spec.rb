require 'spec_helper'
require_relative '../app/location'

RSpec.describe Location do
  describe 'initialize' do
    describe 'when no coordinates are provided as parameters' do
      subject { Location.new }

      it 'finds random coords' do
        expect(subject.quadrant.x).to be_between(1, 8)
        expect(subject.quadrant.y).to be_between(1, 8)
        expect(subject.sector.x).to be_between(1, 8)
        expect(subject.sector.y).to be_between(1, 8)
      end
    end

    describe 'when quadrant coordinates are provided as parameters but sector coords are left to chance' do
      subject { Location.new quadrant: { x: 4, y: 4 } }

      it 'accepts input coords and finds random for the other set' do
        expect(subject.quadrant.x).to eq 4
        expect(subject.quadrant.y).to eq 4
        expect(subject.sector.x).to be_between(1, 8)
        expect(subject.sector.y).to be_between(1, 8)
      end
    end

    describe 'when quadrant and sector coords are provided' do
      subject { Location.new quadrant: { x: 4, y: 4 }, sector: { x: 4, y: 4 } }

      it 'accepts given coords' do
        expect(subject.quadrant.x).to eq 4
        expect(subject.quadrant.y).to eq 4
        expect(subject.sector.x).to eq 4
        expect(subject.sector.y).to eq 4
      end
    end

    describe 'when coord parameters are out of bounds' do
      subject { Location.new quadrant: { x: 9, y: -1 } }

      it 'throws an ArgumentError' do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
