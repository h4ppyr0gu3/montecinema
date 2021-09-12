require 'rails_helper'

RSpec.describe Vouchers::UseCases::Create do
  it 'returns a DB entry' do
    expect(described_class.new({
                                 code: 'fwsrf',
                                 value: 234,
                                 points_required: 10,
                                 expiration_date: Time.zone.now + 1.hour
                               }).call.class).to eq(Vouchers::Model)
  end

  it 'raises error if invalid' do
    expect do
      described_class.new({
                            code: 'fwsrf',
                            value: 234,
                            points_required: 10
                          }).call
    end.to raise_error(Vouchers::UseCases::Create::InvalidParams)
  end
end
