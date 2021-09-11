describe Movies::Representers::Single do 

	let(:call_class) { described_class.new(
		Movies::Model.last
		).call}

	before do 
		create(:movie)
	end

	it 'returns movie json' do
		expect(call_class[:data][:attributes].keys)
		.to contain_exactly(:description, :director, :genre, :length, :title)
	end

	it 'has correct id' do 
		expect(call_class[:data][:id])
		.to eq(Movies::Model.last.id)
	end
end