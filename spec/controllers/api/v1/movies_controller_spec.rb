require 'rails_helper'

RSpec.describe Api::V1::MoviesController do
  describe 'GET #index' do
    subject(:index_request) { get :index }

    let(:index_use_case) { instance_double(Movies::UseCases::Index, call: { movies: 'index' }) }
    let(:index_representer) { instance_double(Movies::Representers::Multiple, call: { movies: 'index' }) }

    before do
      allow(Movies::UseCases::Index).to receive(:new)
        .and_return(index_use_case)
      allow(Movies::Representers::Multiple).to receive(:new)
        .and_return(index_representer)
    end

    context 'when user not logged in' do
      it 'returns index' do
        index_request
        expect(JSON.parse(response.body)).to eq('movies' => 'index')
      end
    end

    context 'when user logged in' do
      it 'returns index' do
        create(:user)
        request.headers.merge! Users::Model.last.create_new_auth_token
        index_request
        expect(JSON.parse(response.body)).to eq('movies' => 'index')
      end
    end
  end

  describe 'GET #show' do
    let(:show_representer) { instance_double(Movies::Representers::Single, call: { movie: 'movie' }) }
    let(:show_request) { get :show, params: { id: Movies::Model.last.id } }

    before do
      create(:movie)
      allow(Movies::Representers::Single).to receive(:new)
        .and_return(show_representer)
    end

    context 'when user logged in' do
      it 'returns movie' do
        create(:user)
        request.headers.merge! Users::Model.last.create_new_auth_token
        show_request
        expect(JSON.parse(response.body)).to eq('movie' => 'movie')
      end
    end

    context 'when user not logged in' do
      it "doesn't returns movie" do
        show_request
        expect(JSON.parse(response.body).keys).to include('error')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_use_case) { instance_double(Movies::UseCases::Delete, call: {}) }
    let(:delete_request) { delete :destroy, params: { id: Movies::Model.last.id } }

    before do
      allow(Movies::UseCases::Delete).to receive(:new)
        .and_return(delete_use_case)
      create(:movie)
    end

    context 'when admin logged in ' do
      it 'deletes movie' do
        create(:user, :admin)
        request.headers.merge! Users::Model.last.create_new_auth_token
        delete_request
        expect(response.status).to eq(200)
      end
    end

    context 'when regular user logged in' do
      it 'returns an error' do
        create(:user, :client)
        request.headers.merge! Users::Model.last.create_new_auth_token
        delete_request
        expect(JSON.parse(response.body).keys).to include('error')
      end
    end
  end

  describe 'POST #create' do
    let(:create_use_case) { instance_double(Movies::UseCases::Create, call: { movie: 'a' }) }
    let(:single_representer) { instance_double(Movies::Representers::Single, call: { movie: 'created' }) }
    let(:create_request) do
      post :create, params:
      {
        data: {
          type: 'movie',
          attributes: {
            title: 'Nuggets 2',
            length: '225',
            description: 'A little bit of gibberish is always good round 2',
            director: 'David Rogers',
            genre: 'The Usual'
          }
        }
      }, as: :json
    end

    before do
      allow(Movies::UseCases::Create).to receive(:new)
        .and_return(create_use_case)
      allow(Movies::Representers::Single).to receive(:new)
        .with(movie: 'a').and_return(single_representer)
    end

    context 'user logged in' do
      before do
        create(:user)
        request.headers.merge! Users::Model.last.create_new_auth_token
      end

      it 'returns error' do
        create_request
        expect(JSON.parse(response.body).keys).to include('error')
      end
    end

    context 'admin logged in' do
      before do
        create(:user, :admin)
        request.headers.merge! Users::Model.last.create_new_auth_token
      end

      it 'allows admin' do
        create_request
        expect(JSON.parse(response.body)).to eq('movie' => 'created')
      end
    end
  end
end
