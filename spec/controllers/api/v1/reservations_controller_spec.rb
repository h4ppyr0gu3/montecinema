require 'rails_helper'

RSpec.describe Api::V1::ReservationsController do
  before do
    create(:movie)
    create(:cinema)
    create(:screening)
  end

  describe 'GET #index' do
    context 'when there is one record' do
      subject { get :index }

      it 'expects one record'
    end

    context 'when there is multiple records' do
      it 'returns all records'
    end
  end
end
