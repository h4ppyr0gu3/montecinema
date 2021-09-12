describe Movies::Representers::Relationship do
  let(:call_class) { described_class.new(Movies::Model.last).call }

  before do
    create(:movie)
  end

  it 'has correct keys' do
    expect(call_class.keys).to contain_exactly(:attributes, :id, :type)
  end

  it 'has correct attributes' do
    expect(call_class[:attributes].keys).to contain_exactly(:description, :director, :genre, :length, :title)
  end
end
