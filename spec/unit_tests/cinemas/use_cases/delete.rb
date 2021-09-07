describe Cinemas::UseCases::Delete do

	let(:call_class) { described_class.new(params: {
		cinema_id: Cinemas::Model.last.id
	}).call}

	before do
		cinema = create(:cinema)
		create_list(:seat, 5, cinema_id: cinema.id)
	end

	it 'destroys cinema' do 
		expect { call_class }.to change(Cinemas::Model, :count).by(-1)
	end

	it 'destroys seats' do 
		expect { call_class }.to change(Seats::Model, :count).by(-5)
	end

	it 'can\'t find cinema' do 
		expect do 
			described_class.new(params: {
				cinema_id: Cinemas::Model.last.id + 1
			}).call
		end.to raise_error(ActiveRecord::RecordNotFound)
	end
end
