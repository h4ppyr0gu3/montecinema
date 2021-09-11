describe Movies::UseCases::Index do 
	let(:params) { {} }
	let(:call_class) { described_class.new(params: params).call }

	before do 
		create_list(:movie, 10)
	end

	it 'returns 5 records' do 
		params[:offset] = 0
		params[:limit] = 5
		expect(call_class.count).to eq(5)
	end 

	it 'returns all records' do 
		expect(call_class.count).to eq(10)
	end
end