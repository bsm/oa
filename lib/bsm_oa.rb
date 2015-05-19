require 'doorkeeper'
require 'bsm-models'
require 'responders'
require 'jbuilder'

require 'bsm_oa/version'
require 'bsm_oa/engine'
require 'bsm_oa/config'

module BsmOa

  class << self

    def configure(&block)
      config.send :instance_eval, &block
    end

    def config
      @config ||= Config.new
    end

    def install_routes!(routes)
      routes.get 'me(.:format)', to: 'bsm_oa/accounts#show'
      routes.use_doorkeeper do
        controllers applications: 'bsm_oa/applications'
      end
    end

  end
end
