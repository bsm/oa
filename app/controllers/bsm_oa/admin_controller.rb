module BsmOa
  class AdminController < BaseController
    before_action :authenticate_admin!
  end
end
