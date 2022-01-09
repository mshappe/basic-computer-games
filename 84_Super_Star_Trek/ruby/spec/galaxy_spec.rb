# frozen_string_literal: true

require 'spec_helper'
require_relative '../app/galaxy'

RSpec.describe Galaxy do
  describe 'initialize' do
    subject { described_class.new }

    it 'sets up the galaxy' do
      expect(subject.quadrants).not_to be_nil
      expect(subject.quadrants.length).to eq 8
      subject.quadrants.each { |r| expect(r.length).to eq 8 }
      expect(subject.total_starbases).to be > 0
      expect(subject.total_klingons).to be > 0
      expect(subject.total_stars).to be > 0
      expect(subject.hero).not_to be_nil
    end

    describe 'when no bases are generated' do
      before { allow_any_instance_of(Quadrant).to receive(:starbases) { 0 } }

      it 'places an additional enemy and two starbase in the starting quadrant' do

      end
    end
  end

  describe '#quadrant' do
    subject { galaxy.quadrant(location) }

    let(:galaxy) { described_class.new }

    let(:location) { Location.new( quadrant: { x: 4, y: 4 } ) }

    it { is_expected.not_to be_nil }
    # Arrays are 0 based, code is 1 based as part of BASIC port
    it { is_expected.to eq galaxy.quadrants[3][3]}
  end
end
