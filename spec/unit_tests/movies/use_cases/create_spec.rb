describe Movies::UseCases::Create do
  let(:params) do
    {
      title: 'good title',
      length: 120,
      director: 'Mario',
      description: 'gibberish',
      genre: 'no idea'
    }
  end
  let(:call_class) { described_class.new(params: params).call }

  context 'with correct params' do
    it 'creates movie' do
      expect { call_class }.to change(Movies::Model, :count).by(1)
    end
  end

  context 'with incorrect params' do
    it 'throws not null error' do
      params[:length] = nil
      expect { call_class }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end
