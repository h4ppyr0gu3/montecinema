require 'swagger_helper'

RSpec.describe 'api/v1/cinemas', type: :request do

  # path '/api/v1/cinemas' do

  #   post 'create cinema' do
  #     parameter name: :data, in: :body, schema: {
  #       type: :object,
  #       properties: {
  #         attributes: {
  #           type: :object,
  #           properties: {
  #             cinema_number: { type: :integer },
  #             rows: { type: :integer },
  #             columns: { type: :integer },
  #             total_seats: { type: :integer },
  #           },
  #         },
  #       },
  #       required: %w[cinema_number rows columns]
  #     } 

  #     response 200, 'successful' do
  #       let(:data) { { cinema_number: 1, rows: 5, columns: 5 } }
  #       run_test!
  #     end
  #   end
  # end
end

  # path '/api/v1/cinemas/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'

  #   get('show cinema') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   patch('update cinema') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   put('update cinema') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end

  #   delete('delete cinema') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }

  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  # end
# end
