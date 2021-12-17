require 'rails_helper'

RSpec.describe 'Goals', type: :request do
  include RequestSpecHelper

  let(:user) { create(:user) }
  let(:headers) { { 'Authorization': login_user(user) } }

  describe 'Goals#Create' do
    it 'creates a new goal' do
      goal = build(:goal, user: user)
      post '/goals', headers: headers, params: { goal: goal.attributes }
      expect(response).to have_http_status(:created)
    end

    it 'creates a new goal and returns the goal attributes' do
      goal = build(:goal, user: user)
      post '/goals', headers: headers, params: { goal: goal.attributes }
      expect(JSON.parse(response.body)['goal']['description']).to eq(goal.description)
    end

    it 'raises ParameterMissing if user params is missing' do
      post '/goals', headers: headers, params: { goal: {} }
      expect(response).to have_http_status(:bad_request)
    end

    it 'raises error message if params is empty or incorrect' do
      post '/goals', headers: headers, params: { goal: { description: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises Unauthorized if token is incorrect or doesnt exist' do
      post '/goals', headers: { 'Authorization': '' }, params: { goal: { amount: 10 } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'Goals#Update' do
    let(:goal) { create(:goal, user: user) }

    it 'updates an existing goal' do
      put "/goals/#{goal.id}", headers: headers, params: { goal: { amount: 10 } }
      expect(response).to have_http_status(:created)

      goal.reload
      expect(goal.amount).to eq(10)
    end

    it 'creates a new goal and returns the goal attributes' do
      put "/goals/#{goal.id}", headers: headers, params: { goal: { amount: 10 } }
      expect(JSON.parse(response.body)['goal']['description']).to eq(goal.description)
    end

    it 'raises ParameterMissing if user params is missing' do
      put "/goals/#{goal.id}", headers: headers, params: { goal: {} }
      expect(response).to have_http_status(:bad_request)
    end

    it 'raises error message if params is empty or incorrect' do
      put "/goals/#{goal.id}", headers: headers, params: { goal: { amount: -10 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises RecordNotFound if goal doesnt exist' do
      put '/goals/0', headers: headers, params: { goal: { amount: 10 } }
      expect(response).to have_http_status(:not_found)
    end

    it 'raises Unauthorized if token is incorrect or doesnt exist' do
      put '/goals/1', headers: { 'Authorization': '' }, params: { goal: { amount: 10 } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
