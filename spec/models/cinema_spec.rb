require 'rails_helper'

RSpec.describe Cinemas::Model, type: :model do
  context 'when there\'s duplicate cinema_number\'s' do
    before do
      create(:cinema, cinema_number: 3)
    end

    it 'invalid test' do
      cinema = described_class.new(cinema_number: 3)
      expect { cinema.save! }.to raise_error ActiveRecord::RecordNotUnique
    end

    it 'valid test' do
      cinema = described_class.new(cinema_number: 4, rows: 2, columns: 2)
      cinema.save
      expect(described_class.count).to be == 2
    end
  end
end
