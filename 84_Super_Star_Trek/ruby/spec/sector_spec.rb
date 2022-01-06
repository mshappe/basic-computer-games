require 'spec_helper.rb'
require_relative '../app/sector'

RSpec.describe Sector do
  describe 'initialize' do
    subject { Sector.new }

    it 'should have a reasonable number of things' do
      expect(subject.klingons).to be_between(0, 3)
      expect(subject.starbase).to be_between(0, 1)
      expect(subject.stars).to be_between(1, 8)
    end
  end
end
