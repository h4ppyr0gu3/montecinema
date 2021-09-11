describe Movies::Representers::Data do 
	let(:call_class) { described_class.new(Movies::Model.last).call }

	before do 
		create(:movie)
	end

	context 'without screening' do
		it 'returns empty screening relationship' do
			expect(call_class[:relationships][:screenings])
			.to be_nil
		end
	end

	context 'with screening' do 
		before do 
			create(:screening, movie_id: Movies::Model.last.id)
		end

		it 'returns relationship' do
			expect(call_class[:relationships][:screenings])
			.not_to be_empty
		end
	end

	it 'has correct attributes' do 
		expect(call_class[:attributes].keys)
		.to contain_exactly(:description, :director, :genre, :length, :title)
	end

	it 'has correct id' do 
		expect(call_class[:id]).to eq(Movies::Model.last.id)		
	end
end

