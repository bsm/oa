module BsmOa
  module Routes

    def self.install!
      ActionDispatch::Routing::Mapper.send :include, Helper
    end

    module Helper

      def mount_bsm_oa
        mount_bsm_oa_me
        mount_bsm_oa_admin
        mount_bsm_oa_callbacks
      end

      def mount_bsm_oa_admin
        mount_bsm_oa_applications
        mount_bsm_oa_roles
        mount_bsm_oa_authorizations
      end

      def mount_bsm_oa_me
        get 'me(.:format)', to: 'bsm_oa/accounts#show', as: :bsm_oa_me
      end

      def mount_bsm_oa_applications
        resources :applications, controller: 'bsm_oa/applications', as: :bsm_oa_applications
      end

      def mount_bsm_oa_roles
        resources :roles, controller: 'bsm_oa/roles', as: :bsm_oa_roles
      end

      def mount_bsm_oa_authorizations
        resources :roles, only: [], as: :bsm_oa_roles do
          resources :authorizations, controller: 'bsm_oa/authorizations', as: :bsm_oa_authorizations, shallow: true do
            put :toggle, on: :member, path: "toggle/:permission"
          end
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
