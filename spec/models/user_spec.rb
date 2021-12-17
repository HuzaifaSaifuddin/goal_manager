require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'has a valid factory' do
    expect(build_stubbed(:user)).to be_valid
  end

  describe 'Validations' do
    it 'is invalid without a username' do
      expect(build_stubbed(:user, username: nil)).to be_invalid
    end
  end

  describe 'Relations' do
    it { expect(User.reflect_on_association(:goals).macro).to eq(:has_many) }
  end

  describe 'encrypt_password' do
    it 'encrypts password with salt' do
      user = build(:user)
      password = user.password
      user.send(:encrypt_password)

      expect(user.salt).to_not eq(nil)
    end

    it 'doesnt encrypted empty password' do
      user = build(:user, password: nil)
      user.send(:encrypt_password)

      expect(user.salt).to eq(nil)
    end
  end

  describe 'downcase_username' do
    it 'downcases the username before saving' do
      username = Faker::Internet.username.upcase
      user = build(:user, username: username)
      user.send(:downcase_username)
      expect(user.username).to eq(username.downcase)
    end
  end
end
