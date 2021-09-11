describe Reservations::UseCases::Index do 

	before do 
		@user = create(:user)
		cinema = create(:cinema)
		movie = create(:movie)
		create(:screening, movie_id: movie.id, cinema_id: cinema.id)
		create_list(:seat, 10, cinema_id: cinema.id)
		create(:reservation, seat_ids: [Seats::Model.last.id], user_id: @user.id)
		create(:reservation, seat_ids: [Seats::Model.first.id], user_id: @user.id)
	end

	context 'with params' do 
		let(:call_class) { described_class.new(params: {query: {
			offset: 0, limit: 1
		}, user: @user
	}).call}

		it 'returns 1 reservation' do 
			expect(call_class.count).to eq(1)
		end
	end

	context 'without params' do
		let(:call_class) { described_class.new(params: {query: {}, user: @user}).call}

		it 'returns 2 reservations' do 
			expect(call_class.count).to eq(2)
		end
	end

	context 'when admin' do
		before do
			create(:user, :support)
		end

		it 'returns 1 reservation' do
			expect(
				described_class.new(params: {query: {
					offset: 0, limit: 1
					}, user: @user
				}).call.count
			).to eq(1)
		end

		it 'returns 2 reservations' do 
			expect(
				described_class.new(params: {query: {}, user: @user}).call.count
			).to eq(2)
		end
	end
end