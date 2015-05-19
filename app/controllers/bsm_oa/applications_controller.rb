module BsmOa
  class ApplicationsController < Doorkeeper::ApplicationsController
    respond_to :html, :json
    before_filter :redirect_to_index_on_html, only: [:show]

    def create
      @application = Doorkeeper::Application.create(application_params)
      location = oauth_application_path(@application) if @application.persisted?
      respond_with @application, location: location
    end

    def update
      @application.update(application_params)
      respond_with @application, location: oauth_application_path(@application)
    end

    def destroy
      respond_with @application, location: oauth_applications_path
    end

    protected

      def application_params
        params.require(:doorkeeper_application).permit(:name, :redirect_uri, :permissions, :permissions_string)
      end

      def redirect_to_index_on_html
        return unless request.format.html?

        flash.keep
        redirect_to oauth_applications_path
      end

  end
end
