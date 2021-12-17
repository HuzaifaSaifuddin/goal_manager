require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Sessions#create' do
    it 'creates a session if username & password are correct' do
      new_user = create(:user)
      new_user.send(:encrypt_password)

      post '/auth/login', params: { username: new_user.username, password: new_user.password }
      expect(response).to have_http_status(:created)
    end

    it 'doesnt creates a session if username & password are incorrect or missing' do
      post '/auth/login', params: { username: '' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
