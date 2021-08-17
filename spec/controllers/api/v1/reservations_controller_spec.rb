require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, focus: true do

	before do 
		create(:movie)
		Cinema.create(cinema_number: 3)
		Screening.create(airing_time: Time.zone.now, cinema_id: Cinema.last.id, movie_id: Movie.last.id)
	end

	describe 'GET #index' do 
		context 'when there is one record' do 
			subject { get :index }
			it 'expects one record' do 
				subject
				puts response.body
			end
		end

		context 'when there is multiple records' do 
			it 'returns all records' do 

			end
		end
	end
end