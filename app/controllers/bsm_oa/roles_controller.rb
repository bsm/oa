module BsmOa
  class RolesController < BaseController
    respond_to :html
    respond_to :json, except: [:new, :edit]

    before_filter :authenticate_admin!
    has_scope     :ordered, default: true, only: [:index]

    def index
      @roles = apply_scopes(resource_scope)
      respond_with @roles
    end

    def show
      @role = resource_scope.find params[:id]
      respond_with @role
    end

    def new
      @role = resource_scope.new
      respond_with @role
    end

    def create
      @role = resource_scope.create permitted_params
      location = bsm_oa_role_url(@role) if @role.persisted?
      respond_with @role, location: location
    end

    def edit
      @role = resource_scope.find params[:id]
      respond_with @role
    end

    def update
      @role = resource_scope.find params[:id]
      @role.update permitted_params
      respond_with @role, location: bsm_oa_role_url(@role)
    end

    def destroy
      @role = resource_scope.find params[:id]
      @role.destroy
      respond_with @role, location: bsm_oa_roles_url
    end

    protected

    # @return [ActiveRecord::Relation]
    def resource_scope
      BsmOa::Role.all
    end

    def permitted_params
      params.require(:role).permit :name, :description
    end

  end
end
