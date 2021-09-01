require 'swagger_helper'

RSpec.describe 'api/v1/cinemas', type: :request do
  path '/api/v1/cinemas' do
    post 'create cinema' do
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
        examples 'application/json' => {
          'data' => { 'type' => 'cinema', 'id' => 1, 'attributes' => { 'cinema_number' => 1, 'rows' => 5, 'columns' => 5, 'total_seats' => 25 }, 'relationships' => { 'seats' => [[{ 'id' => 1, 'attributes' => { 'seat_number' => 'a1' } }, { 'id' => 2, 'attributes' => { 'seat_number' => 'a2' } }, { 'id' => 3, 'attributes' => { 'seat_number' => 'a3' } }, { 'id' => 4, 'attributes' => { 'seat_number' => 'a4' } }, { 'id' => 5, 'attributes' => { 'seat_number' => 'a5' } }, { 'id' => 6, 'attributes' => { 'seat_number' => 'b1' } }, { 'id' => 7, 'attributes' => { 'seat_number' => 'b2' } }, { 'id' => 8, 'attributes' => { 'seat_number' => 'b3' } }, { 'id' => 9, 'attributes' => { 'seat_number' => 'b4' } }, { 'id' => 10, 'attributes' => { 'seat_number' => 'b5' } }, { 'id' => 11, 'attributes' => { 'seat_number' => 'c1' } }, { 'id' => 12, 'attributes' => { 'seat_number' => 'c2' } }, { 'id' => 13, 'attributes' => { 'seat_number' => 'c3' } }, { 'id' => 14, 'attributes' => { 'seat_number' => 'c4' } }, { 'id' => 15, 'attributes' => { 'seat_number' => 'c5' } }, { 'id' => 16, 'attributes' => { 'seat_number' => 'd1' } }, { 'id' => 17, 'attributes' => { 'seat_number' => 'd2' } }, { 'id' => 18, 'attributes' => { 'seat_number' => 'd3' } }, { 'id' => 19, 'attributes' => { 'seat_number' => 'd4' } }, { 'id' => 20, 'attributes' => { 'seat_number' => 'd5' } }, { 'id' => 21, 'attributes' => { 'seat_number' => 'e1' } }, { 'id' => 22, 'attributes' => { 'seat_number' => 'e2' } }, { 'id' => 23, 'attributes' => { 'seat_number' => 'e3' } }, { 'id' => 24, 'attributes' => { 'seat_number' => 'e4' } }, { 'id' => 25, 'attributes' => { 'seat_number' => 'e5' } }]], 'screenings' => [] } }
        }
        let!(:cinema) { { data: { attributes: { cinema_number: 1, rows: 5, columns: 5 } } } }
        run_test! do |_arg|
          # expect { cinema }.to change(Cinemas::Model, :count).by(1)
        end
      end
    end
  end

  path '/api/v1/cinemas/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'id'
    get('show cinema') do
      let!(:cinema) { create(:cinema) }
      response(200, 'successful') do
        let(:id) { Cinemas::Model.last.id }
        run_test!
      end
    end

    # patch('update cinema') do

    #   consumes 'application/json'
    #   parameter name: :cinema, in: :body, schema: {
    #     properties: {
    #       data: {
    #         type: :object,
    #         properties: {
    #           attributes: {
    #             type: :object,
    #             properties: {
    #               cinema_number: { type: :integer, example: 1 },
    #               rows: { type: :integer, example: 5 },
    #               columns: { type: :integer, example: 5 },
    #               total_seats: { type: :integer, example: 25 }
    #             }
    #           }
    #         }
    #       }
    #     },
    #     required: %w[cinema_number rows columns]
    #   }
    #   response(201, 'created') do
    #     let!(:create_cinema) { create(:cinema) }
    #     let(:id) { Cinemas::Model.last.id }
    #     let!(:cinema) { { data: { attributes: { cinema_number: 1, rows: 10, columns: 5 } } } }
    #     examples 'application/json' => {
    #       {"data"=>
    #         {"type"=>"cinema",
    #           "id"=>3,
    #           "attributes"=>{
    #             "cinema_number"=>2,
    #             "rows"=>5,
    #             "columns"=>5,
    #             "total_seats"=>nil
    #           }, "relationships"=>{"seats"=>[[]], "screenings"=>[]}}}

    #     # after do |example|
    #     #   example.metadata[:response][:content] = {
    #     #     'application/json' => {
    #     #       example: JSON.parse(response.body, symbolize_names: true)
    #     #     }
    #     #   }
    #     # end
    #     run_test! do |_arg|
    #     end
    #   end
    # end

    # put('update cinema') do
    #   response(200, 'successful') do
    #     let(:id) { '123' }

    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    delete('delete cinema') do
      response(200, 'no_content') do
        let!(:cinema) { create(:cinema) }
        let!(:id) { Cinemas::Model.last.id }
        run_test!
      end
    end
  end
end
