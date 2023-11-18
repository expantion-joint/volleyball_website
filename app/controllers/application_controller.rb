class ApplicationController < ActionController::Base

  # devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  # devise
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :sex, :birthday])
  end

end
