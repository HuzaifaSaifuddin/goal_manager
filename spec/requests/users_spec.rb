require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Users#create' do
    let(:params) { { username: Faker::Internet.username, password: 'Huzaifa@18' } }

    it 'returns the user_id' do
      post '/auth/signup', params: { user: params }
      expect(JSON.parse(response.body)['user_id']).to eq(1)
    end

    it 'creates a user' do
      post '/auth/signup', params: { user: params }
      expect(response).to have_http_status(:created)
    end

    it 'raises ParameterMissing if user params is missing' do
      post '/auth/signup'
      expect(response).to have_http_status(:bad_request)
    end

    it 'render error message if user params are missing or incorrect' do
      post '/auth/signup', params: { user: { username: '', password: '' } }

      expect(JSON.parse(response.body)['errors']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises uniqueness error if username is taken' do
      new_user = create(:user)
      params[:username] = new_user.username

      post '/auth/signup', params: { user: params }

      expect(JSON.parse(response.body)['errors'][0]).to eq('Username has already been taken')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
