require 'doorkeeper'
require 'responders'
require 'has_scope'

require 'bsm_oa/version'
require 'bsm_oa/engine'
require 'bsm_oa/routes'
require 'bsm_oa/config'

module BsmOa
  class << self

    def configure(&block)
      config.send :instance_eval, &block
    end

    def config
      @config ||= Config.new
    end

  end
end
