describe Movies::UseCases::Update do 
	let(:params) { {
			attributes: {
				title: 'something else'
			}, id: Movies::Model.last.id
	} }
	let(:call_class) { described_class.new(params: params).call }

	before do 
		create(:movie)
	end

	it 'updates an attribute' do
		call_class
		expect(Movies::Model.last.title).to eq('something else') 
	end

	it 'updates attributes' do
		params[:attributes] = {
			title: 'somethin else',
			length: 50,
			genre: 'not comedy'
		}
		expect(call_class).to eq(true)
	end
end