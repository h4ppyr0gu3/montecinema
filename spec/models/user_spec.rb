# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ensures correct validations' do
    user = described_class.new(email: 'test@test.com', password: 'test123')
    user.validate
    expect(user.errors.count).to be(0)
  end
end
