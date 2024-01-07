class AdminsController < ApplicationController

  before_action :authenticate_user!

  def input_password
    render :input_password
  end

  def confirm_password
    if params[:confirm_password] == ENV['ADMIN_PASSWORD']
      session[:confirm] = "Confirmed"
      redirect_to edit_all_user_admin_path, notice: 'パスワードを確認しました'
    else
      redirect_to input_password_admin_path, alert: 'パスワードが違います'
    end
  end

  def edit_all_user
    @users = User.all
    user = User.find(current_user.id)
    
    if session[:confirm] == "Confirmed"
      session.delete(:confirm)
      if user.usertype > 90
        render :edit_all_user
      else
        redirect_to index_post_path
      end
    else
      render :input_password
    end

  end

  def update_all_user
    @user = User.find(params[:id])
    user = User.find(current_user.id)
    
    if user.usertype > 90
      if @user.update(user_params)
        session[:confirm] = "Confirmed"
        redirect_to edit_all_user_admin_path, notice: '更新しました'
      else
        render :edit_all_user, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    user = User.find(current_user.id)
    
    if user.usertype > 90
      @user.destroy
      session[:confirm] = "Confirmed"
      redirect_to edit_all_user_admin_path, notice: '削除しました'
    else
      redirect_to index_post_path
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :usertype, :sex, :birthday)
  end

  def before_confrim_password
    render :input_password
  end

end
