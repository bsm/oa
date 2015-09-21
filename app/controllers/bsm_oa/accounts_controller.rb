module BsmOa
  class AccountsController < BaseController
    before_action :doorkeeper_authorize!
    respond_to    :json

    # GET /me.json
    def show
      @account = BsmOa.config.user_class.find doorkeeper_token.try(:resource_owner_id)
      respond_with @account
    end
  end
end
