require 'spec_helper'

describe BsmOa::AuthorizationsController, type: :controller do

  let(:role)        { create :role }
  let(:resource)    { create :authorization, role: role }

  describe 'routing' do
    it { is_expected.to route(:get, "/roles/1/authorizations").to(action: :index, bsm_oa_role_id: 1) }
    it { is_expected.to route(:get, "/roles/1/authorizations/new").to(action: :new, bsm_oa_role_id: 1) }
    it { is_expected.to route(:post, "/roles/1/authorizations").to(action: :create, bsm_oa_role_id: 1) }
    it { is_expected.to route(:get, "/authorizations/1").to(action: :show, id: 1) }
    it { is_expected.to route(:put, "/authorizations/1").to(action: :update, id: 1) }
    it { is_expected.to route(:get, "/authorizations/1/edit").to(action: :edit, id: 1) }
    it { is_expected.to route(:delete, "/authorizations/1").to(action: :destroy, id: 1) }
    it { is_expected.to route(:put, "/authorizations/1/toggle/admin").to(action: :toggle, id: 1, permission: "admin") }
  end

  describe 'GET index.json' do
    before do
      resource
      get :index, params: {bsm_oa_role_id: role.to_param, format: 'json'}
    end

    it { is_expected.to respond_with(:success) }
  end

  describe 'GET index.html' do
    before do
      resource
      get :index, params: {bsm_oa_role_id: role.to_param}
    end

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET new.html' do
    before do
      get :new, params: {bsm_oa_role_id: role.to_param}
    end
    it { is_expected.to render_template(:new) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET show.html' do
    before do
      get :show, params: {id: resource.to_param}
    end
    it { is_expected.to redirect_to("/roles/#{resource.role.to_param}") }
  end

  describe 'GET show.json' do
    before do
      get :show, params: {id: resource.to_param, format: "json"}
    end
    it { is_expected.to respond_with(:success) }
  end

  describe 'GET edit.html' do
    before do
      get :edit, params: {id: resource.to_param}
    end
    it { is_expected.to render_template(:edit) }
    it { is_expected.to respond_with(:success) }
  end

  describe 'POST create.json (successful)' do
    before do
      role = create(:role)
      post :create, params: {format: 'json', bsm_oa_role_id: role.to_param, bsm_oa_authorization: resource.attributes.merge( permissions: 'admin')}
    end

    it { is_expected.to respond_with(:created) }
  end

  describe 'POST create.html (successful)' do
    before do
      role = create(:role)
      post :create, params: {bsm_oa_authorization: resource.attributes.merge( permissions: 'admin'), bsm_oa_role_id: role.to_param}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("/authorizations/#{BsmOa::Authorization.last.to_param}") }
  end

  describe 'POST create.html (unsuccessful)' do
    before do
      role = create(:role)
      post :create, params: {bsm_oa_role_id: role.to_param, bsm_oa_authorization: { application_id: '' }}
     end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:new) }
  end

  describe 'PUT update.html (successful)' do
    before do
      put :update, params: {id: resource.to_param, bsm_oa_authorization: { permissions: 'admin' }}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("/authorizations/#{BsmOa::Authorization.last.to_param}") }
  end

  describe 'PUT update.html (unsuccessful)' do
    before do
      put :update, params: {id: resource.to_param, bsm_oa_authorization: { application_id: '0' }}
    end

    it { is_expected.to respond_with(:success) }
    it { is_expected.to render_template(:edit) }
  end

  describe 'PUT update.json (successful)' do
    before do
      put :update, params: {format: 'json', id: resource.to_param, bsm_oa_authorization: { permissions: 'admin' }}
    end

    it { is_expected.to respond_with(:no_content) }
  end

  describe 'PUT update.json (unsuccessful)' do
    before do
      put :update, params: {format: 'json', id: resource.to_param, bsm_oa_authorization: { application_id: '0' }}
    end

    it { is_expected.to respond_with(:unprocessable_entity) }
  end

  describe 'PUT toggle' do
    before do
      put :toggle, params: {id: resource.to_param, permission: "admin"}
    end

    it { is_expected.to respond_with(:redirect) }
    it { is_expected.to redirect_to("/authorizations/1") }
  end

  describe 'PUT toggle.js' do
    before do
      put :toggle, params: {id: resource.to_param, permission: "admin", format: "js"}
    end

    it { is_expected.to respond_with(:success) }
    it { expect(resource.reload.permissions).to be_empty }
  end

  describe 'PUT toggle.json' do
    before do
      put :toggle, params: {id: resource.to_param, permission: "admin", format: "json"}
    end

    it { is_expected.to respond_with(:no_content) }
  end

end


