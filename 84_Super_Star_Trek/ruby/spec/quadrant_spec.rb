require 'spec_helper.rb'
require_relative '../app/quadrant'

RSpec.describe Quadrant do
  let(:galaxy) { Galaxy.new }

  describe 'initialize' do
    subject { described_class.new(galaxy, x: 4, y: 4) }

    it 'should have a reasonable number of things' do
      expect(subject.klingons).to be_between(0, 3)
      expect(subject.starbases).to be_between(0, 2)
      expect(subject.stars).to be_between(1, 8)
    end
  end

  describe '#tweak' do
    let(:quadrant) { described_class.new(galaxy, x: 4, y: 4) }

    describe 'add_klingons' do
      subject { quadrant.tweak add_klingons: 1 }

      it 'revises quadrant numbers' do
        expect { subject }.to change { quadrant.klingons }.by 1
      end

      it 'revises galaxy numbers' do
        expect { subject }.to change { quadrant.galaxy.total_klingons }.by 1
      end
    end

    describe 'add_starbases' do
      subject { quadrant.tweak add_starbases: 1 }

      it 'revises quadrant numbers' do
        expect { subject }.to change { quadrant.starbases }.by 1
      end

      it 'revises galaxy numbers' do
        expect { subject }.to change { quadrant.galaxy.total_starbases }.by 1
      end
    end
  end

  describe '#name' do
    8.times.each do |y|
      8.times.each do |x|
        it do
          quadrant = galaxy.quadrants[y][x]
          expected_name = Quadrant::NAMES[x < 4 ? y : y + 8]
          expected_subname = Quadrant::SUBNAMES[x < 4 ? x : x - 4]

          expect(quadrant.name).to match /#{expected_name}\s#{expected_subname}/
        end
      end
    end
  end
end
