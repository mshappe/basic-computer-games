require 'spec_helper'
require_relative '../app/quadrant'

RSpec.describe Quadrant do
  let(:galaxy) { Galaxy.new }

  describe 'initialize' do
    subject { described_class.new(galaxy, x: 4, y: 4, random: -> { 0.99 }) }

    it 'should have a reasonable number of things' do
      expect(subject.num_klingons).to eq 3
      expect(subject.starbase?).to be_truthy
      expect(subject.num_stars).to be_between(1, 8)

      # The map is seeded when the hero arrives, so
      # we initialize to empty space for now
      subject.sectors.each do |y|
        y.each { |x| expect(x).to eq Quadrant::TOKENS[:space] }
      end
    end
  end

  describe '#tweak' do
    let(:quadrant) { described_class.new(galaxy, x: 4, y: 4) }

    describe 'add_klingons' do
      subject { quadrant.tweak add_klingons: 1 }

      it 'revises quadrant numbers' do
        expect { subject }.to change { quadrant.num_klingons }.by 1
      end

      it 'revises galaxy numbers' do
        expect { subject }.to change { quadrant.galaxy.total_klingons }.by 1
      end
    end

    describe 'add_starbases' do
      subject { quadrant.tweak add_starbase: true }

      it 'revises quadrant numbers' do
        expect { subject }.to change { quadrant.starbase? }.to be_truthy
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

  describe '#place_entity' do
    let(:quadrant) { described_class.new(galaxy, x: 4, y: 4) }

    describe 'the hero' do
      before { quadrant.place_entity(:hero, x: 7, y: 1 ) }
      it { expect(quadrant.sector(x: 7, y: 1)).to eq Quadrant::TOKENS[:hero] }
    end

    describe 'a villain' do
      before { quadrant.place_entity(:villain, x:7, y: 1 ) }
      it { expect(quadrant.sector(x: 7, y: 1)).to eq Quadrant::TOKENS[:villain] }
    end

    describe 'a starbase' do
      before { quadrant.place_entity(:starbase, x: 7, y: 1) }
      it { expect(quadrant.sector(x: 7, y: 1)).to eq Quadrant::TOKENS[:starbase] }
    end

    describe 'a star' do
      before { quadrant.place_entity(:star, x: 7, y: 1) }
      it { expect(quadrant.sector(x: 7, y: 1)).to eq Quadrant::TOKENS[:star] }
    end

    describe 'space' do
      before { quadrant.place_entity(:space, x: 7, y: 1) }
      it { expect(quadrant.sector(x: 7, y: 1)).to eq Quadrant::TOKENS[:space] }
    end

    describe 'a lizard' do
      it { expect { quadrant.place_entity(:lizard, x: 7, y: 1) }.to raise_error ArgumentError }
    end
  end

  describe 'find_space' do
    subject { quadrant.find_space }

    let(:quadrant) { described_class.new(galaxy, x: 4, y: 4) }

    it { is_expected.to be_a Location }
  end

  describe 'hero_arrives' do
    let(:quadrant) { described_class.new(galaxy, x: 4, y: 4, random: -> { 0.99 }) }

    before do
      # Guarantee klingons, starbases, and stars
      quadrant.hero_arrives
    end

    it 'places the hero' do
      expect(quadrant.sector(x: quadrant.hero.location.sector.x,
                             y: quadrant.hero.location.sector.y))
        .to eq Quadrant::TOKENS[:hero]
    end

    it 'places the villains' do
      expect(quadrant.klingons.count).to eq quadrant.num_klingons
      quadrant.klingons.each do |klingon|
        expect(quadrant.sector(x: klingon.location.sector.x,
                               y: klingon.location.sector.y))
          .to eq Quadrant::TOKENS[:villain]
      end
    end

    it 'places the starbase(s)' do
      expect(quadrant.starbase?).to be_truthy
      expect(quadrant.sector(x: quadrant.starbase.sector.x,
                             y: quadrant.starbase.sector.y))
        .to eq Quadrant::TOKENS[:starbase]
    end

    it 'places stars' do
      expect(quadrant.num_stars).to be > 0
      expect(quadrant.stars.count).to eq quadrant.num_stars
      quadrant.stars do |star|
        expect(quadrant.sector(x: star.sector.x, y: star.sector.y))
          .to eq Quadrant::TOKENS[:star]
      end
    end
  end
end
