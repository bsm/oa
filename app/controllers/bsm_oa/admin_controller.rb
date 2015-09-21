module BsmOa
  class AdminController < BaseController
    before_filter :authenticate_admin!
  end
end
