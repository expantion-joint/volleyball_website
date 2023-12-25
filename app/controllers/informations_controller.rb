class InformationsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    user = User.find(current_user.id)
    if user.usertype > 90
      @informations = Information.all
      render :index
    else
      redirect_to index_post_path
    end
  end

  def new
    user = User.find(current_user.id)
    if user.usertype > 90
      @information = Information.new
      render :new
    else
      redirect_to index_post_path
    end
  end

  def create
    @information = Information.new(information_params)
    user = User.find(current_user.id)

    if params[:information][:image]
      @information.image.attach(params[:information][:image])
    end

    if user.usertype > 90
      if @information.save
        redirect_to index_information_path, notice: '投稿しました'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def edit
    @information = Information.find(params[:id])
    user = User.find(current_user.id)
    if user.usertype > 90
      render :edit
    else
      redirect_to index_post_path
    end
  end

  def update
    @information = Information.find(params[:id])
    user = User.find(current_user.id)

    if params[:information][:image]
      @information.image.attach(params[:information][:image])
    end
    
    if user.usertype > 90
      if @information.update(information_params)
        redirect_to index_information_path, notice: '更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def destroy
    @information = Information.find(params[:id])
    user = User.find(current_user.id)
    if user.usertype > 90
      @information.destroy
      redirect_to index_information_path, notice: '削除しました'
    else
      redirect_to index_post_path
    end
  end

  private
  
  def information_params
    params.require(:information).permit(:title, :public_or_private, :image)
  end

end
