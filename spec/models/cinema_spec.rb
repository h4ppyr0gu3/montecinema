require 'rails_helper'

RSpec.describe Cinema, type: :model do
  context 'no duplicate cinema_number\'s' do 
    before do
      Cinema.create(cinema_number: 3)
    end

    it 'invalid test' do
      cinema = Cinema.new(cinema_number: 3)
      cinema.save
      expect { cinema.save! }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'valid test' do
      cinema = Cinema.new(cinema_number: 4)
      cinema.save
      expect(Cinema.count).to be == 2
    end
  end
end
