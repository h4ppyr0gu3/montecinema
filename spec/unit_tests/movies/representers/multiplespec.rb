describe Movies::Representers::Multiple do 
	let(:call_class) { described_class.new(Movies::Model.all).call }
	before do 
		create(:movie)
		create(:movie, title: 'gibberish here')
	end

	it 'returns meta count' do
		expect(call_class[:meta][:total_count]).to eq(2)
	end

	it 'returns correct data count' do 
		expect(call_class[:data].count).to eq(2)
	end
end