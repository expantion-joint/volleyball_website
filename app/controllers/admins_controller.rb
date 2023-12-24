class AdminsController < ApplicationController

  before_action :authenticate_user!

  def edit_all_user
    @users = User.all
    user = User.find(current_user.id)
    
    if user.usertype > 90
      render :edit_all_user
    else
      redirect_to index_post_path
    end

  end

  def update_all_user
    @user = User.find(params[:id])
    user = User.find(current_user.id)
    
    if user.usertype > 90
      if @user.update(user_params)
          redirect_to edit_all_user_admin_path, notice: '更新しました'
      else
          render :edit_all_user, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :usertype, :sex, :birthday)
  end

end
