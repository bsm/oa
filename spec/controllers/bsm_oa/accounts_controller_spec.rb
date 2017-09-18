require 'spec_helper'

describe BsmOa::AccountsController, type: :controller do
  include Rack::Test::Methods

  let(:authorization) { create :authorization }
  let(:application)   { authorization.application }
  let(:user)          { create :user, roles: [authorization.role] }
  let(:access_token)  { Doorkeeper::AccessToken.create! resource_owner_id: user.id, application_id: application.id }
  let(:app)           { Rails.application }

  describe 'GET show.json (successful)' do
    before do
      get "/me.json", {client_id: application.uid, client_secret: application.secret}, {"HTTP_AUTHORIZATION" => "Bearer #{access_token.token}"}
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(last_response.headers).to include("Content-Type" => "application/json; charset=utf-8") }
  end

  describe 'GET show.json (expired)' do
    before do
      access_token.update_column :resource_owner_id, 0
      get "/me.json", {client_id: application.uid, client_secret: application.secret}, {"HTTP_AUTHORIZATION" => "Bearer #{access_token.token}"}
    end

    it { expect(last_response.status).to eq(403) }
  end

  describe 'GET show.json (bad auth token)' do
    before do
      get "/me.json", {client_id: application.uid, client_secret: application.secret}, {"HTTP_AUTHORIZATION" => "Bearer abcdef"}
    end

    it { expect(last_response.status).to eq(401) }
  end

end
