require 'spec_helper'
require_relative '../app/timekeeper'

RSpec.describe Timekeeper do
  let(:galaxy) { Galaxy.new }

  describe 'initialize' do
    subject { Timekeeper.new(galaxy) }

    it 'should set up stardates' do
      expect(subject.beginning).not_to be_nil
      expect(subject.end).to be > subject.beginning
      expect(subject.end).to eq subject.beginning + subject.duration
    end

    describe 'when there are more klingons than days' do
      # This is a preposterous number of Klingons but should be
      # more than ever gets generated for days
      before { allow(galaxy).to receive(:total_klingons) { 1000 } }

      it 'always allows one more day than there are enemies' do
        expect(subject.duration).to eq galaxy.total_klingons + 1
      end
    end
  end

  describe '#tick' do
    subject { tk.tick(5) }

    let(:tk) { Timekeeper.new(galaxy) }

    it 'should advance 5 days' do
      is_expected.to eq tk.beginning + 5
      is_expected.to eq tk.now
    end
  end
end
