describe Movies::UseCases::Delete do 
	let(:params) { {} }
	let(:call_class) { described_class.new(params: params).call }
	let(:movie_id) { Movies::Model.last.id }

	before do
		create(:movie)
	end

	it 'deletes record' do 
		params[:id] = movie_id
		expect { call_class }.to change(Movies::Model, :count).by(-1)
	end

	it 'throws record not found' do 
		params[:id] = movie_id + 1
		expect { call_class }.to raise_error(ActiveRecord::RecordNotFound)
	end
end