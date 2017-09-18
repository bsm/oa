require 'spec_helper'

describe BsmOa::RolesController, type: :controller do

  let(:resource)  { create :role }
  let(:user)     { create :user }

  describe 'routing' do
    it { is_expected.to route(:get, "/roles").to(action: :index) }
    it { is_expected.to route(:get, "/roles/new").to(action: :new) }
    it { is_expected.to route(:get, "/roles/1").to(action: :show, id: 1) }
    it { is_expected.to route(:get, "/roles/1/edit").to(action: :edit, id: 1) }
    it { is_expected.to route(:post, "/roles").to(action: :create) }
    it { is_expected.to route(:put, "/roles/1").to(action: :update, id: 1) }
  end

  describe 'GET index.json' do
    before do
      resource
      get :index, params: {format: 'json'}
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.json' do
    before do
      get :show, params: {id: resource.to_param, format: 'json'}
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'POST create.json (successful)' do
    before do
      post :create, params: {format: 'json', bsm_oa_role: build(:role).attributes }
    end

    it { is_expected.to respond_with(:created) }
  end

  describe 'PUT update.json (successful)' do
    before do
      put :update, params: {format: 'json', id: resource.to_param, bsm_oa_role: { name: "newname"}}
    end

    it { is_expected.to respond_with(:no_content) }
  end

  describe 'GET index.html' do
    before do
      get :index
    end

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.html' do
    before do
      get :show, params: {id: resource.to_param}
    end

    it { is_expected.to render_template(:show) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET edit.html' do
    before do
      get :edit, params: {id: resource.to_param}
    end
    it { is_expected.to render_template(:edit) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET new.html' do
    before do
      get :new
    end
    it { is_expected.to render_template(:new) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'POST create.html (successful)' do
    before do
      post :create, params: {bsm_oa_role: build(:role).attributes}
    end
    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/roles/#{BsmOa::Role.last.to_param}") }
  end

  describe 'POST create.html (unsuccessful)' do
    before do
      post :create, params: {bsm_oa_role: resource.attributes}
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }
  end

  describe 'PUT update.html (successful)' do
    before do
      post :update, params: {id: resource.to_param, bsm_oa_role: { name: "newname"}}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/roles/#{resource.to_param}") }
  end

  describe 'PUT update.html (unsuccessful)' do
    before do
      put :update, params: {id: resource.to_param, bsm_oa_role: { name: "" }}
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:edit) }
  end

  describe 'DELETE destroy.json' do
    before do
      delete :destroy, params: {format: 'json', id: resource.to_param}
    end

    it { is_expected.to respond_with(:no_content) }
  end

  describe 'DELETE destroy.html' do
    before do
      delete :destroy, params: {id: resource.to_param}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("http://test.host/roles") }
  end

end


