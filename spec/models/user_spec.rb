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

    it 'is invalid without a password while creating record' do
      user = build(:user, password: nil)
      expect(user.save).to be_falsy
      # Alternatively
      # expect do
      #   create(:user, password: nil)
      # end.to raise_error ActiveRecord::RecordInvalid
    end

    it 'is valid without a password while updating record' do
      user = create(:user)
      expect(user.update(password: nil)).to be_truthy
    end
  end

  describe 'Relations' do
    it { expect(User.reflect_on_association(:goals).macro).to eq(:has_many) }
  end

  describe 'self.authenticate' do
    it 'authenticates user' do
      user = create(:user)
      user.send(:encrypt_password)

      auth_user = User.authenticate(user.username, user.password)
      expect(auth_user).to_not eq(nil)
    end

    it 'fails authentication if username is incorrect' do
      auth_user = User.authenticate(Faker::Internet.username, 'Password')

      expect(auth_user).to eq(nil)
    end

    it 'fails authentication if username is not present' do
      auth_user = User.authenticate('', 'Password')
      expect(auth_user).to eq(nil)
    end

    it 'fails authentication if password is not present' do
      auth_user = User.authenticate(Faker::Internet.username, '')
      expect(auth_user).to eq(nil)
    end

    it 'fails authentication if password is incorrect' do
      user = create(:user)
      user.send(:encrypt_password)

      auth_user = User.authenticate(user.username, 'Incorrect Password')

      expect(auth_user).to eq(nil)
    end
  end

  describe 'match_password' do
    it 'validates password with salt' do
      user = create(:user)
      password = user.password
      user.send(:encrypt_password)

      expect(user.match_password(password)).to be_truthy
    end

    it 'fails validation when password is incorrect' do
      user = create(:user)
      user.send(:encrypt_password)

      expect(user.match_password('Incorrect Password')).to be_falsy
    end
  end

  describe 'encrypt_password' do
    it 'encrypts password with salt' do
      user = build(:user)
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
