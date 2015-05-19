require 'spec_helper'

describe BsmOa::ApplicationsController, type: :controller do

  it { is_expected.to be_a(Doorkeeper::ApplicationsController) }

  let(:user)         { create :user }
  let!(:application) { create :application }

  describe 'routing' do
    it { is_expected.to route(:get,  "/oauth/applications").to(action: :index) }
    it { is_expected.to route(:post, "/oauth/applications").to(action: :create) }
    it { is_expected.to route(:get,  "/oauth/applications/new").to(action: :new) }
    it { is_expected.to route(:get,  "/oauth/applications/1").to(action: :show, id: 1) }
    it { is_expected.to route(:put,  "/oauth/applications/1").to(action: :update, id: 1) }
    it { is_expected.to route(:delete, "/oauth/applications/1").to(action: :destroy, id: 1) }
  end

  describe 'authorisation' do
    pending "REVIEW!"
  end

  describe 'GET index.json' do
    before do
      get :index, format: 'json'
    end

    it { expect(response.body).to have_json_size(1) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.json' do
    before do
      get :show, format: 'json', id: application.to_param
    end

    it { expect(response.body).to have_json_size(6) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.html' do
    before do
      get :show, format: 'html', id: application.to_param
    end

    it { is_expected.to redirect_to("http://test.host/oauth/applications") }
  end

  describe 'POST create.json (successful)' do
    before do
      post :create, format: 'json', doorkeeper_application: application.attributes
    end

    it { expect(response.body).to have_json_size(6) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'POST create.json (unsuccessful)' do
    before do
      post :create, format: 'json', doorkeeper_application: application.attributes.merge(name: nil)
    end

    it { expect(response.body).to have_json_path('errors') }
    it { is_expected.to respond_with(:unprocessable_entity) }
  end

  describe 'POST create.html' do
    before do
      post :create, doorkeeper_application: application.attributes
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/oauth/applications/#{Doorkeeper::Application.last.to_param}") }
  end

  describe 'PUT update.json (successful)' do
    before do
      put :update, format: 'json', id: application.to_param, doorkeeper_application: application.attributes
    end

    it { expect(response.body).to have_json_size(6) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'PUT update.json (unsuccessful)' do
    before do
      put :update, format: 'json', id: application.to_param, doorkeeper_application: application.attributes.merge(name: nil)
    end

    it { expect(response.body).to have_json_path('errors') }
    it { is_expected.to respond_with(:unprocessable_entity) }
  end

  describe 'PUT update.html' do
    before do
      put :update, id: application.to_param, doorkeeper_application: application.attributes
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/oauth/applications/#{application.to_param}") }
  end

  describe 'DELETE destroy.json' do
    before do
      delete :destroy, format: 'json', id: application.to_param
    end

    it { is_expected.to respond_with(:no_content) }
  end

  describe 'DELETE destroy.html' do
    before do
      delete :destroy, id: application.to_param
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/oauth/applications") }
  end
end
