class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_date_loaded
  before_action :authorize

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

  private
    def set_date_loaded
      @date_loaded = Time.now
    end
end
