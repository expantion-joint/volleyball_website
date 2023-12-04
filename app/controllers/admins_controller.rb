class AdminsController < ApplicationController

  before_action :authenticate_user!

  def edit_all_user
    @users = User.all
    render :edit_all_user
  end

  def update_all_user
    @user = User.find(params[:id])
    
    if @user.update(user_params)
        redirect_to edit_all_user_admin_path, notice: '更新しました'
    else
        render :edit_all_user, status: :unprocessable_entity
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :usertype, :sex, :birthday)
  end

end
