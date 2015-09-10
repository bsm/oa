 module BsmOa
  class AuthorizationsController < Doorkeeper::ApplicationController
    respond_to :html
    respond_to :json, except: [:new, :edit]
    respond_to :js, only: [:toggle]

    before_filter :authenticate_admin!
    before_filter :redirect_to_index_on_html, only: [:show]

    def index
      @authorizations = apply_scopes(resource_scope)
      respond_with @authorizations
    end

    def show
      @authorization = resource_scope.find params[:id]
      respond_with @authorization
    end

    def new
      @authorization = resource_scope.new
      respond_with @authorization
    end

    def edit
      @authorization = resource_scope.find params[:id]
      respond_with @authorization
    end

    def create
      @authorization = resource_scope.create permitted_params
      respond_with @authorization
    end

    def update
      @authorization = resource_scope.find params[:id]
      @authorization.update(permitted_params)
      respond_with @authorization, location: bsm_oa_authorization_path(@authorization)
    end

    def toggle
      @authorization = resource_scope.find params[:id]
      @authorization.toggle(params[:permission])
      respond_with @authorization
    end

    def destroy
      @authorization = resource_scope.find params[:id]
      @authorization.destroy
      respond_with @authorization, location: bsm_oa_authorization_path(@authorization)
    end

    protected

    # @return [User]
    def parent
      @parent ||= BsmOa::Role.find params[:bsm_oa_role_id]
    end

    # @return [ActiveRecord::Relation]
    def resource_scope
      if params[:bsm_oa_role_id]
        parent.authorizations.all
      else
        BsmOa::Authorization.all
      end
    end

    def permitted_params
      params.require(:authorization).permit :application_id, :permissions_string, :uid, :secret
    end

    def redirect_to_index_on_html
      return unless request.format.html?

      flash.keep
      @authorization ||= resource_scope.find params[:id]
      redirect_to bsm_oa_role_path(@authorization.role)
    end

  end
end
