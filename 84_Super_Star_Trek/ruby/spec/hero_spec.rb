require 'spec_helper'
require_relative '../app/hero'

RSpec.describe Hero do
  let(:galaxy) { Galaxy.new }

  describe 'initialize' do
    subject { Hero.new(galaxy) }

    it 'is all dressed up with places to go' do
      expect(subject.energy).to eq Hero::MAX_ENERGY
      expect(subject.torpedoes).to eq Hero::MAX_TORPEDOES
      expect(subject.shields).to eq 0
      expect(subject.timekeeper).not_to be_nil
      expect(subject.location).not_to be_nil
      expect(subject.systems).not_to be_nil
    end
  end

  describe 'orders' do
    subject { hero.orders }

    let(:hero) { Hero.new(galaxy) }

    it 'describes the mission' do
      is_expected.to match %r[#{galaxy.total_klingons} Klingon warships]
      is_expected.to match %r[Stardate #{hero.timekeeper.end}]
      is_expected.to match %r[#{hero.timekeeper.duration} days]
      is_expected.to match %r[#{galaxy.total_starbases} Starbase]
    end
  end
end
