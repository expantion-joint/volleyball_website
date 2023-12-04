class ApplicationController < ActionController::Base

  # devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 投稿者登録済みかの確認
  before_action :contributor_verification

  # devise
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :sex, :birthday, :usertype])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :sex, :birthday, :usertype])
  end

  def contributor_verification
    if user_signed_in?
      @contributor = Contributor.find_by(user_id: current_user.id)
    end
  end

end
