require 'swagger_helper'

RSpec.describe 'api/v1/cinemas', type: :request do
  path '/api/v1/movies' do
    post 'create movie' do
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

      response 201, :created do
        examples 'application/json' => {"data"=>{"type"=>"movie", "id"=>1, "attributes"=>{"title"=>"something", "description"=>"something else", "genre"=>"comedy", "director"=>"wejndan", "length"=>95}, "relationships"=>{"screenings"=>[]}}}

        let!(:movie) { { data: { attributes: { title: 'something', description: 'something else', length: 95, director: 'wejndan', genre: 'comedy' } } } }
        run_test! do |_arg|
        end
      end

      get 'index movies' do 
        parameter name: :offset, in: :query, type: :integer, description: 'offset of records in db', required: false
        parameter name: :limit, in: :query, type: :integer, description: 'number of records to be returned', required: false

        response 200, 'success' do 
          let!(:create_movie) { create(:movie) }
          examples 'application/json' => {"data"=>[{"type"=>"movie", "id"=>2, "attributes"=>{"title"=>"Autobiography", "description"=>"Best description", "genre"=>"comedy", "director"=>"Me, Mario", "length"=>125}, "relationships"=>{"screenings"=>[]}}], "meta"=>{"total_count"=>1}} 
          run_test! do |_arg|
          end
        end
      end
    end

    path '/api/v1/movies/{id}' do
      get 'show movies' do
        parameter name: :id, in: :path
        response 200, 'success' do
          examples 'application/json' => {"data"=>{"type"=>"movie", "id"=>3, "attributes"=>{"title"=>"Autobiography", "description"=>"Best description", "genre"=>"comedy", "director"=>"Me, Mario", "length"=>125}, "relationships"=>{"screenings"=>[]}}}
          let!(:create_movie) { create(:movie) }
          let(:id) { Movies::Model.last.id }
          run_test! do |_arg|
          end
        end
      end
    end
  end

  # path '/api/v1/cinemas/{id}' do
  #   parameter name: :id, in: :path, type: :string, description: 'id'
  #   get('show cinema') do
  #     let!(:cinema) { create(:cinema) }
  #     response(200, 'successful') do
  #       let(:id) { Cinemas::Model.last.id }
  #       run_test!
  #     end
  #   end

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


#   delete('delete cinema') do
#     response(200, 'no_content') do
#       let!(:cinema) { create(:cinema) }
#       let!(:id) { Cinemas::Model.last.id }
#       run_test!
#     end
#   end
# end
end
