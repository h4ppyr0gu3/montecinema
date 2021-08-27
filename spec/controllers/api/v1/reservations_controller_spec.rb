require 'rails_helper'

RSpec.describe Api::V1::ReservationsController do
  before do
    create(:movie)
    create(:cinema)
    create(:screening)
  end

  describe 'GET #index' do
    subject(:request) { get :index }

    it 'expects one record' do 
      request
      expect(JSON.parse(response.body)['data'].count).to eq(1)
    end

    it 'returns all records' do 
      create(:movie, title: 'something Else', length: 134)
      request
      expect(JSON.parse(response.body)['data'].count).to eq(2)
    end
  end
end
