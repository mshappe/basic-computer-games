# frozen_string_literal: true

require 'spec_helper'
require_relative '../app/galaxy'

RSpec.describe Galaxy do
  describe 'initialize' do
    subject { Galaxy.new }

    it 'created a map' do
      expect(subject.map).not_to be_nil
      expect(subject.map.length).to eq 8
      subject.map.each { |r| expect(r.length).to eq 8 }
    end
  end
end
