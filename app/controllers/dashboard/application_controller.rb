module Dashboard
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    prepend_before_action :require_login

    add_flash_types :success, :info, :warning, :danger

    private

    def not_authenticated
      redirect_to dashboard_login_path
    end

    def current_user
      super if super.presence
    end
  end
end
