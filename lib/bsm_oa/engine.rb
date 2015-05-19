module BsmOa
  class Engine < Rails::Engine
    isolate_namespace BsmOa

    initializer 'bsm_oa.migrations' do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |path|
          app.config.paths["db/migrate"] << path
        end
      end
    end

    initializer "bsm_oa.models" do
      ActiveSupport.on_load(:active_record) do
        require 'bsm_oa/application_mixin'
        require 'bsm_oa/authorization'
        require 'bsm_oa/role'

        Doorkeeper::Application.send :include, ApplicationMixin
      end
    end

  end
end
