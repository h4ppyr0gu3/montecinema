require 'rails_helper'

RSpec.describe Cinema, type: :model do
  context 'no duplicate cinema_number\'s' do
    before do
      described_class.create(cinema_number: 3)
    end

    it 'invalid test' do
      cinema = described_class.new(cinema_number: 3)
      cinema.save
      expect { cinema.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'valid test' do
      cinema = described_class.new(cinema_number: 4)
      cinema.save
      expect(described_class.count).to be == 2
    end
  end
end
