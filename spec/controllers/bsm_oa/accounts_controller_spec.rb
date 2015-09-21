require 'spec_helper'

describe BsmOa::AccountsController, type: :controller do

  let(:authorization) { create :authorization }
  let(:application)   { authorization.application }
  let(:user)          { create :user, roles: [authorization.role] }
  let(:access_token)  { Doorkeeper::AccessToken.create! resource_owner_id: user.id, application_id: application.id }

  describe 'routing' do
    it { is_expected.to route(:get, "/me").to(action: :show) }
  end

  describe 'GET show.json (successful)' do
    before do
      request.headers["Authorization"] = "Bearer #{access_token.token}"
      get :show, client_id: application.uid, client_secret: application.secret, format: 'json'
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.json (bad auth token)' do
    before do
      request.headers["Authorization"] = "Bearer abcdef"
      get :show, format: 'json'
    end

    it { is_expected.to respond_with(:unauthorized) }
  end

end
