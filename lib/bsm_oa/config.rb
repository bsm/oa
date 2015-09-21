module BsmOa
  class Config

    def user_class(value = nil)
      if value.nil?
        @user_class = @user_class.constantize if String === @user_class
        @user_class ||= "::User".constantize
      else
        @user_class = value
      end
    end

    def user_attrs(*attrs)
      @user_attrs = attrs unless attrs.empty?
      @user_attrs ||= [:id, :email]
    end

    def parent_controller(name = nil)
      @parent_controller = name if name
      @parent_controller ||= "ApplicationController"
    end

  end
end
