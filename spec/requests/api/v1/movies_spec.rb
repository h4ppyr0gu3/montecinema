require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  let(:Authorization) { 'Bearer string' }
  let(:'access-token') { 'random string' }
  let(:'token-type') { 'Bearer' }
  let(:client) { 'random string' }
  let(:uid) { 'Users email' }

  before do
    Users::Model.create!(email: 'test@test.com', password: 'test123', role: :admin)
  end

  path '/api/v1/movies' do
    post 'create movie' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Movies'
      consumes 'application/json'
      parameter name: :movie, in: :body, schema: {
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  title: { type: :string, example: 'Nobody' },
                  genre: { type: :string, example: 'Action' },
                  director: { type: :string, example: 'Bob 2' },
                  description: { type: :string, example: 'action movie' },
                  length: { type: :integer, example: 90 }
                }
              }
            }
          }
        },
        required: %w[title genre director description length]
      }

      let!(:user) { create(:user, :admin) }

      response 201, :created do
        examples 'application/json' => { 'data' => { 'type' => 'movie', 'id' => 1,
                                                     'attributes' => { 'title' => 'something', 'description' => 'something else', 'genre' => 'comedy', 'director' => 'wejndan', 'length' => 95 }, 'relationships' => { 'screenings' => nil } } }

        let(:movie) do
          { data: { attributes: { title: 'something', description: 'something else', length: 95, director: 'wejndan',
                                  genre: 'comedy' } } }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).not_to be_nil
        end
      end
    end

    get 'index movies with params' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Movies'

      parameter name: :offset, in: :query, type: :integer, description: 'offset of records in db'
      parameter name: :limit, in: :query, type: :integer, description: 'number of records to be returned'

      response 200, 'success' do
        examples 'application/json' => {
          'data' => [{ 'type' => 'movie', 'id' => 3,
                       'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'genre' => 'comedy', 'director' => 'Me, Mario', 'length' => 125 }, 'relationships' => { 'screenings' => nil } }], 'meta' => { 'total_count' => 2 }
        }

        let!(:create_movie) { create_list(:movie, 2) }
        let(:limit) { 1 }
        let(:offset) { 1 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data'].count).to eq(1)
          expect(data['meta']['total_count']).to eq(2)
        end
      end
    end

    get 'index movies without params' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Movies'

      response 200, 'success' do
        examples 'application/json' => {
          'data' => [
            { 'type' => 'movie', 'id' => 4,
              'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'genre' => 'comedy', 'director' => 'Me, Mario', 'length' => 125 }, 'relationships' => { 'screenings' => nil } }, { 'type' => 'movie', 'id' => 5, 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'genre' => 'comedy', 'director' => 'Me, Mario', 'length' => 125 }, 'relationships' => { 'screenings' => nil } }
          ], 'meta' => { 'total_count' => 2 }
        }

        let!(:create_movie) { create_list(:movie, 2) }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data'].count).to eq(2)
          expect(data['meta']['total_count']).to eq(2)
        end
      end
    end
  end

  path '/api/v1/movies/{id}' do
    get 'show movies' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Movies'

      parameter name: :id, in: :path

      response 200, 'success' do
        examples 'application/json' => { 'data' => { 'type' => 'movie', 'id' => 2,
                                                     'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'genre' => 'comedy', 'director' => 'Me, Mario', 'length' => 125 }, 'relationships' => { 'screenings' => nil } } }
        let!(:create_movie) { create(:movie) }
        let(:id) { Movies::Model.last.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).not_to be_nil
        end
      end
    end
  end
end
