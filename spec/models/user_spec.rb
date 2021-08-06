# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ensures correct validations' do
    user = User.new(email: 'test@test.com', password: 'test123')
    user.validate
    expect(user.errors.count).to eql(0)
  end
end
