require 'spec_helper'
require_relative '../app/utilities'

class UseUtilities
  extend Utilities
end

RSpec.describe Utilities do
  describe '.special_random' do
    describe 'default' do
      subject { UseUtilities.special_random }

      it { is_expected.to be_between(0, 7) }
    end

    describe 'one_based: true' do
      subject { UseUtilities.special_random one_based: true }

      it { is_expected.to be_between(1, 8) }
    end
  end
end
