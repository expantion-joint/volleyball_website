class InformationsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @informations = Information.all
    render :index
  end

  def new
    @information = Information.new
    render :new
  end

  def create
    @information = Information.new(information_params)
   
    if params[:information][:image]
      @information.image.attach(params[:information][:image])
    end

    if @information.save
      redirect_to index_information_path, notice: '投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @information = Information.find(params[:id])
    render :edit
  end

  def update
    @information = Information.find(params[:id])
    
    if params[:information][:image]
      @information.image.attach(params[:information][:image])
    end
    
    if @information.update(information_params)
      redirect_to index_information_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @information = Information.find(params[:id])
    @information.destroy
    redirect_to index_information_path, notice: '削除しました'
  end

  private
  
  def information_params
    params.require(:information).permit(:title, :public_or_private, :image)
  end

end
