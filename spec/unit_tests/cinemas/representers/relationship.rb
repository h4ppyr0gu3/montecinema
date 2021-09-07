describe Cinemas::Representers::Relationship do 

	let(:call_class) { described_class.new(
		cinema: Cinemas::Model.last).call}

	before do 
		create(:cinema)
	end

	it 'has correct attributes' do 
		expect(call_class[:attributes].keys).to contain_exactly(
			:cinema_number, :total_seats, :rows, :columns
		)
	end

	it 'has id' do 
		expect(call_class.keys).to contain_exactly(
			:type, :id, :attributes
		)
	end
end