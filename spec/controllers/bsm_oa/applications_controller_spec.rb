require 'spec_helper'

describe BsmOa::ApplicationsController, type: :controller do

  let(:user)        { create :user }
  let(:application) { create :application }

  describe 'routing' do
    it { is_expected.to route(:get,     "/applications")      .to(action: :index) }
    it { is_expected.to route(:post,    "/applications")      .to(action: :create) }
    it { is_expected.to route(:get,     "/applications/new")  .to(action: :new) }
    it { is_expected.to route(:get,     "/applications/1")    .to(action: :show, id: 1) }
    it { is_expected.to route(:put,     "/applications/1")    .to(action: :update, id: 1) }
    it { is_expected.to route(:delete,  "/applications/1")    .to(action: :destroy, id: 1) }
  end

  describe 'GET index.json' do
    before do
      application
      get :index, format: 'json'
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.json' do
    before do
      get :show, params: {format: 'json', id: application.to_param}
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.html' do
    before do
      get :show, params: {format: 'html', id: application.to_param}
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'POST create.json (successful)' do
    before do
      post :create, params: {format: 'json', bsm_oa_application: attributes_for(:application)}
    end

    it { is_expected.to respond_with(:created) }
  end

  describe 'POST create.json (unsuccessful)' do
    before do
      post :create, params: {format: 'json', bsm_oa_application: attributes_for(:application, name: nil)}
    end

    it { is_expected.to respond_with(:unprocessable_entity) }
  end

  describe 'POST create.html' do
    before do
      post :create, params: {bsm_oa_application: attributes_for(:application)}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/applications/#{BsmOa::Application.last.to_param}") }
  end

  describe 'PUT update.json (successful)' do
    before do
      put :update, params: {format: 'json', id: application.to_param, bsm_oa_application: application.attributes}
    end

    it { is_expected.to respond_with(:no_content) }
  end

  describe 'PUT update.json (unsuccessful)' do
    before do
      put :update, params: {format: 'json', id: application.to_param, bsm_oa_application: build(:application, name: nil).attributes}
    end

    it { is_expected.to respond_with(:unprocessable_entity) }
  end

  describe 'PUT update.html' do
    before do
      put :update, params: {id: application.to_param, bsm_oa_application: application.attributes}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/applications/#{application.to_param}") }
  end

  describe 'DELETE destroy.json' do
    before do
      delete :destroy, params: {format: 'json', id: application.to_param}
    end

    it { is_expected.to respond_with(:no_content) }
  end

  describe 'DELETE destroy.html' do
    before do
      delete :destroy, params: {id: application.to_param}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/applications") }
  end
end
