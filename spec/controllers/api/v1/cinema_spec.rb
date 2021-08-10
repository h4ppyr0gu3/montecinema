# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CinemasController do
  it 'GET #index' do
    Cinema.create(cinema_number: 5)
    get :index
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).count).to eq(1)
    Cinema.create(cinema_number: 5)
    get :index
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body).count).to eq(1)
    Cinema.create(cinema_number: 6)
    get :index
    expect(JSON.parse(response.body).count).to eq(2)
  end

  it 'GET #show' do
    Cinema.create(cinema_number: 5)
    Cinema.create(cinema_number: 3)
    Cinema.create(cinema_number: 1)
    cinema_id = Cinema.last.id
    get :show, params: { id: cinema_id }
    expect(JSON.parse(response.body).class).to eq(Hash)
  end

  it 'POST #create' do
    count = Cinema.count
    post :create, params: { rows: 10, columns: 10, cinema_number: 5 }, as: :json
    expect(count).to eql(Cinema.count - 1)
  end

  it 'DELETE #destroy' do
    post :create, params: { rows: 10, columns: 10, cinema_number: 5 }, as: :json
    seat_count = Seat.count
    cinema_count = Cinema.count
    delete :destroy, params: { id: Cinema.last.id }
    expect(Cinema.count).to be < cinema_count
    expect(Seat.count).to be < seat_count
  end
end
