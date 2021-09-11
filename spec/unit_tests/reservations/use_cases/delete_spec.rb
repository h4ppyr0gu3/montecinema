describe Reservations::UseCases::Delete do 
	let(:call_class) { described_class.new(
		params: { reservation: Reservations::Model.last }
	).call }

	before do 
		create(:user)
		cinema = create(:cinema)
		movie = create(:movie)
		create(:screening, movie_id: movie.id, cinema_id: cinema.id)
		create_list(:seat, 10, cinema_id: cinema.id)
		create(:reservation, seat_ids: [Seats::Model.last.id])
	end

	it 'deletes position' do
		expect { call_class }.to change(Positions::Model, :count).by(-1)
	end

	it 'deletes reservation' do 
		expect { call_class }.to change(Reservations::Model, :count).by(-1)
	end
end