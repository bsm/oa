module BsmOa
  class AccountsController < ActionController::Metal
    include AbstractController::Callbacks
    include ActionController::Head
    include Doorkeeper::Rails::Helpers

    before_action :doorkeeper_authorize!

    # GET /me.json
    def show
      self.content_type = Mime[:json]
      self.response_body = account.respond_to?(:oa_json) ? account.oa_json : account.to_json
    end

    private

      def valid_doorkeeper_token?
        !!account && super
      end

      def account
        return @_account if defined?(@_account)
        @_account = BsmOa.config.user_class.find_by_id doorkeeper_token.try(:resource_owner_id)
      end

  end
end
