require 'rails_helper'

RSpec.describe Users::Model, type: :model do
  it 'ensures correct validations' do
    user = described_class.new(email: 'test@test.com', password: 'test123')
    user.validate
    expect(user.errors.count).to be(0)
  end

  it 'presence of first and last_name' do
    user = described_class.new(email: 'test@test.com',
                               password: 'test123',
                               first_name: 'David',
                               last_name: 'Rogers')
    user.validate
    expect(user.errors.count).to be(0)
  end

  it 'invalid email syntax' do
    user = described_class.new(email: 'tes@t@test.com', password: 'test123')
    user.validate
    expect(user.errors.count).to be > 0
  end

  it 'invalid password' do
    user = described_class.new(email: 'tes@t@test.com', password: 'test')
    user.validate
    expect(user.errors.count).to be > 0
  end
end
