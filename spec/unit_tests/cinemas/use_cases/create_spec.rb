describe Cinemas::UseCases::Create do 
	let(:call_class) {
		described_class.new(params: {
			cinema_number: 1,
			rows: 5,
			columns: 1
		}).call
	}

	context 'errors' do 
		before do 
			create(:cinema, cinema_number: 1)
		end

		it 'raises cinema taken' do 
			expect { call_class }.to raise_error(Cinemas::UseCases::Create::CinemaNumberAlreadyTaken)
		end
	end

	context 'success' do 
		before do 
			create(:cinema, cinema_number: 2)
		end
		it 'creates cinema' do
			expect { call_class }
			.to change(Cinemas::Model, :count).by(1)
		end

		it 'creates seats' do 
			expect { call_class }
			.to change(Seats::Model, :count).by(5)
		end
	end
end