require 'swagger_helper'

RSpec.describe 'api/v1/cinemas', type: :request do
  let(:Authorization) { 'Bearer string' }
  let(:'access-token') { 'random string' }
  let(:'token-type') { 'Bearer' }
  let(:client) { 'random string' }
  let(:uid) { 'Users email' }

  before do
    Users::Model.create!(email: 'test@test.com', password: 'test123', role: :admin)
  end

  path '/api/v1/cinemas' do
    post 'create cinema' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Cinemas'
      consumes 'application/json'
      parameter name: :cinema, in: :body, schema: {
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  cinema_number: { type: :integer, example: 1 },
                  rows: { type: :integer, example: 5 },
                  columns: { type: :integer, example: 5 },
                  total_seats: { type: :integer, example: 25 }
                }
              }
            }
          }
        },
        required: %w[cinema_number rows columns]
      }

      response 201, :created do
        examples 'application/json' => { 'data' => { 'type' => 'cinema', 'id' => 1,
                                                     'attributes' => { 'cinema_number' => 1, 'rows' => 5, 'columns' => 5, 'total_seats' => 25 }, 'relationships' => { 'seats' => [{ 'id' => 1, 'attributes' => { 'seat_number' => 'a1' } }, { 'id' => 2, 'attributes' => { 'seat_number' => 'a2' } }, { 'id' => 3, 'attributes' => { 'seat_number' => 'a3' } }, { 'id' => 4, 'attributes' => { 'seat_number' => 'a4' } }, { 'id' => 5, 'attributes' => { 'seat_number' => 'a5' } }, { 'id' => 6, 'attributes' => { 'seat_number' => 'b1' } }, { 'id' => 7, 'attributes' => { 'seat_number' => 'b2' } }, { 'id' => 8, 'attributes' => { 'seat_number' => 'b3' } }, { 'id' => 9, 'attributes' => { 'seat_number' => 'b4' } }, { 'id' => 10, 'attributes' => { 'seat_number' => 'b5' } }, { 'id' => 11, 'attributes' => { 'seat_number' => 'c1' } }, { 'id' => 12, 'attributes' => { 'seat_number' => 'c2' } }, { 'id' => 13, 'attributes' => { 'seat_number' => 'c3' } }, { 'id' => 14, 'attributes' => { 'seat_number' => 'c4' } }, { 'id' => 15, 'attributes' => { 'seat_number' => 'c5' } }, { 'id' => 16, 'attributes' => { 'seat_number' => 'd1' } }, { 'id' => 17, 'attributes' => { 'seat_number' => 'd2' } }, { 'id' => 18, 'attributes' => { 'seat_number' => 'd3' } }, { 'id' => 19, 'attributes' => { 'seat_number' => 'd4' } }, { 'id' => 20, 'attributes' => { 'seat_number' => 'd5' } }, { 'id' => 21, 'attributes' => { 'seat_number' => 'e1' } }, { 'id' => 22, 'attributes' => { 'seat_number' => 'e2' } }, { 'id' => 23, 'attributes' => { 'seat_number' => 'e3' } }, { 'id' => 24, 'attributes' => { 'seat_number' => 'e4' } }, { 'id' => 25, 'attributes' => { 'seat_number' => 'e5' } }], 'screenings' => nil } } }
        let(:cinema) { { data: { attributes: { cinema_number: 1, rows: 5, columns: 5 } } } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).not_to be_nil
        end
      end
    end
  end

  path '/api/v1/cinemas/{id}' do
    parameter name: :id, in: :path, type: :integer
    before do
      Cinemas::Model.create!(cinema_number: 10, rows: 5, columns: 5)
    end

    get 'show cinema' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Cinemas'
      response(200, 'successful') do
        examples 'application/json' => { 'data' => { 'type' => 'cinema', 'id' => 1,
                                                     'attributes' => { 'cinema_number' => 1, 'rows' => 5, 'columns' => 5, 'total_seats' => 25 }, 'relationships' => { 'seats' => [{ 'id' => 1, 'attributes' => { 'seat_number' => 'a1' } }, { 'id' => 2, 'attributes' => { 'seat_number' => 'a2' } }, { 'id' => 3, 'attributes' => { 'seat_number' => 'a3' } }, { 'id' => 4, 'attributes' => { 'seat_number' => 'a4' } }, { 'id' => 5, 'attributes' => { 'seat_number' => 'a5' } }, { 'id' => 6, 'attributes' => { 'seat_number' => 'b1' } }, { 'id' => 7, 'attributes' => { 'seat_number' => 'b2' } }, { 'id' => 8, 'attributes' => { 'seat_number' => 'b3' } }, { 'id' => 9, 'attributes' => { 'seat_number' => 'b4' } }, { 'id' => 10, 'attributes' => { 'seat_number' => 'b5' } }, { 'id' => 11, 'attributes' => { 'seat_number' => 'c1' } }, { 'id' => 12, 'attributes' => { 'seat_number' => 'c2' } }, { 'id' => 13, 'attributes' => { 'seat_number' => 'c3' } }, { 'id' => 14, 'attributes' => { 'seat_number' => 'c4' } }, { 'id' => 15, 'attributes' => { 'seat_number' => 'c5' } }, { 'id' => 16, 'attributes' => { 'seat_number' => 'd1' } }, { 'id' => 17, 'attributes' => { 'seat_number' => 'd2' } }, { 'id' => 18, 'attributes' => { 'seat_number' => 'd3' } }, { 'id' => 19, 'attributes' => { 'seat_number' => 'd4' } }, { 'id' => 20, 'attributes' => { 'seat_number' => 'd5' } }, { 'id' => 21, 'attributes' => { 'seat_number' => 'e1' } }, { 'id' => 22, 'attributes' => { 'seat_number' => 'e2' } }, { 'id' => 23, 'attributes' => { 'seat_number' => 'e3' } }, { 'id' => 24, 'attributes' => { 'seat_number' => 'e4' } }, { 'id' => 25, 'attributes' => { 'seat_number' => 'e5' } }], 'screenings' => nil } } }
        let(:id) { Cinemas::Model.last.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).to eq(id)
        end
      end
    end

    delete 'delete cinema' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Cinemas'
      response(200, 'ok') do
        examples 'application/json' => {}
        let(:id) { Cinemas::Model.last.id }
        run_test! do |_response|
          expect(Cinemas::Model.count).to eq(0)
        end
      end
    end
  end
end
