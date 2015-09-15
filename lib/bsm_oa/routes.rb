module BsmOa
  module Routes

    def self.install!
      ActionDispatch::Routing::Mapper.send :include, Helper
    end

    module Helper

      def mount_bsm_oa
        mount_bsm_oa_admin
        mount_bsm_oa_callbacks
      end

      def mount_bsm_oa_admin
        get 'me(.:format)', to: 'bsm_oa/accounts#show', as: :bsm_oa_me
        resources :roles, controller: 'bsm_oa/roles', as: :bsm_oa_roles do
          resources :authorizations, controller: 'bsm_oa/authorizations', as: :bsm_oa_authorizations, shallow: true do
            put :toggle, on: :member, path: "toggle/:permission"
          end
        end
        use_doorkeeper scope: "" do
          controllers applications: 'bsm_oa/applications'
          skip_controllers :authorized_applications, :authorizations, :tokens
        end
      end

      def mount_bsm_oa_callbacks
        use_doorkeeper do
          skip_controllers :applications, :authorized_applications
        end
      end

    end
  end
end
