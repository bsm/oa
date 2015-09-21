module BsmOa
  class BaseController < BsmOa.config.parent_controller.constantize
    include Doorkeeper::Helpers::Controller
  end
end
