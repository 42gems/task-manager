class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :authorize, unless: :devise_controller?

  protected
  def authorize
    unless current_user.can_manage? current_project
      render file: "#{Rails.root}/public/403.html", status: 403, layout: false
    end
  end
end
