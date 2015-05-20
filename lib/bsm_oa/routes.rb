module BsmOa
  module Routes

    def self.install!
      ActionDispatch::Routing::Mapper.send :include, Helper
    end

    module Helper

      def mount_bsm_oa
        get 'me(.:format)', to: 'bsm_oa/accounts#show', as: :bsm_oa_me
        resources :roles, controller: 'bsm_oa/roles', as: :bsm_oa_roles do
          resources :authorizations, controller: 'bsm_oa/authorizations', as: :bsm_oa_authorizations, shallow: true do
            put :toggle, on: :member, path: "toggle/:permission"
          end
        end
        use_doorkeeper do
          controllers applications: 'bsm_oa/applications'
        end
      end

    end
  end
end
