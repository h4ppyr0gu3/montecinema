require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  let(:Authorization) { 'Bearer string' }
  let(:'access-token') { 'random string' }
  let(:'token-type') { 'Bearer' }
  let(:client) { 'random string' }
  let(:uid) { 'Users email' }

  path '/api/v1/reservations' do
    post 'create reservation' do
      tags 'Reservations'
      consumes 'application/json'
      # PLEASE NOTE:
      # These specs only work because i disabled authentication for test env
      # when executing them as i was struggling to get the headers to pass
      # as i couldn't set the users header
      # as you can see i tried

      # and this is also very unreadable and not dry
      # Help in future with writing docs would be much appreciated

      # components {
      # header { description: 'gibberish atm', schema:{ type: :string } }
      # header name: 'client', schema:{ type: :string }
      # header name: 'uid', schema:{ type: :string }
      # parameter name: 'Authorization', in: :header, type: :string
      # parameter name: 'access-token', in: :header, type: :string
      # parameter name: 'uid', in: :header, type: :string
      # parameter name: 'client', in: :header, type: :string
      # parameter name: 'token-type', in: :header, type: :string, default: 'Bearer'
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]

      parameter name: :reservation, in: :body, schema: {
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  user_id: { type: :integer },
                  screening_id: { type: :integer },
                  cinema_id: { type: :integer },
                  movie_id: { type: :integer },
                  seat_ids: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        seat_id: { type: :integer }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      response 201, :created do
        examples 'application/json' => { 'data' => { 'type' => 'reservation', 'id' => 1, 'attributes' => {},
                                                     'relationships' => { 'user' => { 'id' => 1, 'attributes' => { 'first_name' => nil, 'last_name' => nil, 'email' => 'test@test.com', 'points_earned' => 0, 'points_redeemed' => 0 } }, 'movie' => { 'id' => 1, 'type' => 'movie', 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'director' => 'Me, Mario', 'genre' => 'comedy', 'length' => 125 } }, 'screening' => { 'id' => 1, 'attributes' => { 'airing_time' => '2021-09-12T14:46:39.447Z', 'additional_cost' => 0, 'seats_available' => nil, 'movie_id' => 1 } }, 'cinema' => { 'type' => 'cinema', 'id' => 1, 'attributes' => { 'cinema_number' => 1, 'total_seats' => nil, 'rows' => 5, 'columns' => 5 } }, 'seats' => [{ 'id' => 10, 'attributes' => { 'seat_number' => '10' } }] } } }
        let(:movie) { create(:movie) }
        let(:cinema) { create(:cinema) }
        let(:screening) { create(:screening, movie_id: movie.id, cinema_id: cinema.id) }
        let(:seats) { create_list(:seat, 10, cinema_id: cinema.id) }
        let(:'access-token') { @token[:token] }
        let(:'token-type') { 'Bearer' }
        let(:client) { @token[:client] }
        let(:uid) { @user.email }
        let(:Authorization) { "Bearer #{@token[:client]}" }
        let(:reservation) do
          {
            data: {
              attributes: {
                user_id: @user.id,
                cinema_id: cinema.id,
                movie_id: movie.id,
                screening_id: screening.id,
                seat_ids: [
                  {
                    seat_id: seats.last.id
                  }
                ]
              }
            }
          }
        end
        let!(:user) do
          @user = Users::Model.create!(email: 'test@test.com', password: 'test123')
          @token = DeviseTokenAuth::TokenFactory.create
          @user.tokens[@token.client] = {
            token: @token.token_hash,
            expiry: @token.expiry
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).not_to be_nil
        end
      end
    end
  end

  path '/api/v1/reservations/{id}' do
    let(:user) { create(:user, :admin) }
    let(:cinema) { create(:cinema) }
    let(:movie) { create(:movie) }
    let(:cinema) { create(:cinema) }
    let(:screening) { create(:screening, movie_id: movie.id, cinema_id: cinema.id) }
    let(:seats) { create_list(:seat, 10, cinema_id: cinema.id) }
    let(:reservation) { create(:reservation, movie_id: movie.id, cinema_id: cinema.id, screening_id: screening.id) }
    parameter name: :id, in: :path, type: :string, description: 'id'
    get 'show reservation' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]

      tags 'Reservations'

      response(200, 'successful') do
        examples 'application/json' => { 'data' => { 'type' => 'reservation', 'id' => 2, 'attributes' => {},
                                                     'relationships' => { 'user' => { 'id' => 2, 'attributes' => { 'first_name' => 'David', 'last_name' => 'Rogers', 'email' => 'test1@test.com', 'points_earned' => 0, 'points_redeemed' => 0 } }, 'movie' => { 'id' => 2, 'type' => 'movie', 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'director' => 'Me, Mario', 'genre' => 'comedy', 'length' => 125 } }, 'screening' => { 'id' => 2, 'attributes' => { 'airing_time' => '2021-09-12T15:27:51.232Z', 'additional_cost' => 0, 'seats_available' => nil, 'movie_id' => 2 } }, 'cinema' => { 'type' => 'cinema', 'id' => 2, 'attributes' => { 'cinema_number' => 2, 'total_seats' => nil, 'rows' => 5, 'columns' => 5 } }, 'seats' => [] } } }
        let(:id) { reservation.id }
        run_test!
      end
    end

    delete 'delete reservation' do
      tags 'Reservations'

      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]

      response(200, 'successful') do
        let(:id) { reservation.id }
        run_test! do |_response|
          expect(Reservations::Model.count).to eq(0)
        end
      end
    end

    put 'update reservation' do
      tags 'Reservations'

      consumes 'application/json'
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]

      parameter name: :reservation, in: :body, schema: {
        properties: {
          data: {
            type: :object,
            properties: {
              attributes: {
                type: :object,
                properties: {
                  user_id: { type: :integer },
                  screening_id: { type: :integer },
                  cinema_id: { type: :integer },
                  movie_id: { type: :integer },
                  seat_ids: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        seat_id: { type: :integer }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      let(:movie) { create(:movie) }
      let(:cinema) { create(:cinema) }
      let(:screening) { create(:screening, movie_id: movie.id, cinema_id: cinema.id) }
      let(:seats) { create_list(:seat, 10, cinema_id: cinema.id) }
      let(:reservation_first) do
        create(:reservation, movie_id: movie.id, cinema_id: cinema.id, screening_id: screening.id)
      end

      response 200, :success do
        examples 'application/json' => { 'data' => { 'type' => 'reservation', 'id' => 4, 'attributes' => {},
                                                     'relationships' => { 'user' => { 'id' => 5, 'attributes' => { 'first_name' => 'David', 'last_name' => 'Rogers', 'email' => 'test4@test.com', 'points_earned' => 0, 'points_redeemed' => 0 } }, 'movie' => { 'id' => 4, 'type' => 'movie', 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'director' => 'Me, Mario', 'genre' => 'comedy', 'length' => 125 } }, 'screening' => { 'id' => 4, 'attributes' => { 'airing_time' => '2021-09-12T15:27:51.309Z', 'additional_cost' => 0, 'seats_available' => nil, 'movie_id' => 4 } }, 'cinema' => { 'type' => 'cinema', 'id' => 4, 'attributes' => { 'cinema_number' => 4, 'total_seats' => nil, 'rows' => 5, 'columns' => 5 } }, 'seats' => [{ 'id' => 20, 'attributes' => { 'seat_number' => '20' } }] } } }
        let(:id) { reservation_first.id }
        let(:reservation) do
          {
            data: {
              attributes: {
                user_id: user.id,
                cinema_id: cinema.id,
                movie_id: movie.id,
                screening_id: screening.id,
                seat_ids: [
                  {
                    seat_id: seats.last.id
                  }
                ]
              }
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data']['id']).not_to be_nil
          expect(data['data']['id']).to eq(reservation_first.id)
        end
      end
    end
  end

  path '/api/v1/reservations' do
    get 'index with params' do
      parameter name: :limit, in: :query, type: :integer
      parameter name: :offset, in: :query, type: :integer
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]

      let(:movie) { create(:movie) }
      let(:cinema) { create(:cinema) }
      let(:cinema2) { create(:cinema) }
      let(:screening) { create(:screening, movie_id: movie.id, cinema_id: cinema.id) }
      let(:screening2) { create(:screening, movie_id: movie.id, cinema_id: cinema2.id) }
      let(:seats) { create_list(:seat, 10, cinema_id: cinema.id) }
      let!(:reservation_first) do
        create(:reservation, movie_id: movie.id, cinema_id: cinema.id, screening_id: screening.id)
      end
      let!(:reservation_second) do
        create(:reservation, movie_id: movie.id, cinema_id: cinema2.id, screening_id: screening2.id)
      end
      let!(:user) { create(:user, :admin) }

      response 200, :success do
        examples 'application/json' => { 'data' => [{ 'type' => 'reservation', 'id' => 6, 'attributes' => {},
                                                      'relationships' => { 'user' => { 'id' => 8, 'attributes' => { 'first_name' => 'David', 'last_name' => 'Rogers', 'email' => 'test7@test.com', 'points_earned' => 0, 'points_redeemed' => 0 } }, 'movie' => { 'id' => 5, 'type' => 'movie', 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'director' => 'Me, Mario', 'genre' => 'comedy', 'length' => 125 } }, 'screening' => { 'id' => 6, 'attributes' => { 'airing_time' => '2021-09-12T15:42:38.260Z', 'additional_cost' => 0, 'seats_available' => nil, 'movie_id' => 5 } }, 'cinema' => { 'type' => 'cinema', 'id' => 6, 'attributes' => { 'cinema_number' => 6, 'total_seats' => nil, 'rows' => 5, 'columns' => 5 } }, 'seats' => [] } }] }
        let(:limit) { 1 }
        let(:offset) { 1 }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data'].count).to eq(1)
        end
      end
    end

    get 'index without params' do
      security [access_token: [], client: [], uid: [], token_type: [], auth_type: []]
      tags 'Reservations'

      let(:movie) { create(:movie) }
      let(:cinema) { create(:cinema) }
      let(:cinema2) { create(:cinema) }
      let(:screening) { create(:screening, movie_id: movie.id, cinema_id: cinema.id) }
      let(:screening2) { create(:screening, movie_id: movie.id, cinema_id: cinema2.id) }
      let(:seats) { create_list(:seat, 10, cinema_id: cinema.id) }
      let!(:reservation_first) do
        create(:reservation, movie_id: movie.id, cinema_id: cinema.id, screening_id: screening.id)
      end
      let!(:reservation_second) do
        create(:reservation, movie_id: movie.id, cinema_id: cinema2.id, screening_id: screening2.id)
      end
      let!(:user) { create(:user, :admin) }

      response 200, :success do
        examples 'application/json' => { 'data' => [
          { 'type' => 'reservation', 'id' => 7, 'attributes' => {},
            'relationships' => { 'user' => { 'id' => 11, 'attributes' => { 'first_name' => 'David', 'last_name' => 'Rogers', 'email' => 'test10@test.com', 'points_earned' => 0, 'points_redeemed' => 0 } }, 'movie' => { 'id' => 6, 'type' => 'movie', 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'director' => 'Me, Mario', 'genre' => 'comedy', 'length' => 125 } }, 'screening' => { 'id' => 7, 'attributes' => { 'airing_time' => '2021-09-12T15:45:50.552Z', 'additional_cost' => 0, 'seats_available' => nil, 'movie_id' => 6 } }, 'cinema' => { 'type' => 'cinema', 'id' => 7, 'attributes' => { 'cinema_number' => 7, 'total_seats' => nil, 'rows' => 5, 'columns' => 5 } }, 'seats' => [] } }, { 'type' => 'reservation', 'id' => 8, 'attributes' => {}, 'relationships' => { 'user' => { 'id' => 11, 'attributes' => { 'first_name' => 'David', 'last_name' => 'Rogers', 'email' => 'test10@test.com', 'points_earned' => 0, 'points_redeemed' => 0 } }, 'movie' => { 'id' => 6, 'type' => 'movie', 'attributes' => { 'title' => 'Autobiography', 'description' => 'Best description', 'director' => 'Me, Mario', 'genre' => 'comedy', 'length' => 125 } }, 'screening' => { 'id' => 8, 'attributes' => { 'airing_time' => '2021-09-12T15:45:50.563Z', 'additional_cost' => 0, 'seats_available' => nil, 'movie_id' => 6 } }, 'cinema' => { 'type' => 'cinema', 'id' => 8, 'attributes' => { 'cinema_number' => 8, 'total_seats' => nil, 'rows' => 5, 'columns' => 5 } }, 'seats' => [] } }
        ] }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data'].count).to eq(2)
        end
      end
    end
  end
end
