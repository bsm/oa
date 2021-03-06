module BsmOa
  class ApplicationsController < AdminController
    respond_to :html
    respond_to :json, except: [:new, :edit]
    has_scope  :ordered, default: true, only: [:index]

    def index
      @applications = apply_scopes(resource_scope)
      respond_with @applications
    end

    def show
      respond_with resource
    end

    def new
      @application = resource_scope.new
      respond_with @application
    end

    def edit
      respond_with resource
    end

    def create
      @application = resource_scope.create permitted_params
      respond_with @application
    end

    def update
      resource.update(permitted_params)
      respond_with resource
    end

    def destroy
      resource.destroy
      respond_with resource, location: bsm_oa_applications_path
    end

    protected

      def resource
        @application ||= resource_scope.find params[:id]
      end

      # @return [ActiveRecord::Relation]
      def resource_scope
        BsmOa::Application.all
      end

      def permitted_params
        params.require(:bsm_oa_application).permit(:name, :redirect_uri, :permissions, :uid, :secret)
      end

  end
end
