require 'rails_helper'

RSpec.describe Api::V1::CinemasController do
  context 'when GET #index' do
    subject { get :index }

    it 'return one object' do
      Cinema.create(cinema_number: 5)
      subject
      expect(JSON.parse(response.body).count).to eq(1)
    end

    it 'return multiple objects' do
      create_cinemas 2
      subject
      expect(JSON.parse(response.body).count).to eq(2)
    end
  end

  it 'GET #show' do
    create_cinemas 3
    cinema_id = Cinema.last.id
    get :show, params: { id: cinema_id }
    expect(JSON.parse(response.body).class).to eq(Hash)
  end

  it 'POST #create' do
    expect { post :create, params: { rows: 10, columns: 10, cinema_number: 5 }, as: :json }
    .to change { Cinema.count }.by(1)
  end

  context 'when DELETE #destroy' do
    subject { delete :destroy, params: { id: Cinema.last.id } }

    let(:creation) do
      post :create, params: { rows: 10, columns: 10, cinema_number: 5 }, as: :json
    end

    before do
      creation
    end

    it 'delete seats' do
      expect { subject }.to change{ Seat.count }.by(-100)
    end

    it 'delete cinema' do
      expect { subject }.to change{ Cinema.count }.by(-1)
    end
  end
end

def create_cinemas(number)
  cinema_numbers = (1..10).to_a
  cinema_numbers = cinema_numbers.take(number)
  cinema_numbers.each do |cinema_number|
    Cinema.create(cinema_number: cinema_number)
  end
end
