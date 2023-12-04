class ContributorsController < ApplicationController

  before_action :authenticate_user!

  def index
    all_posts = Post.all
    @posts = []

    all_posts.each do |post|
      @contributor = Contributor.find(post.contributor_id)
      if @contributor.user_id == current_user.id
        @posts << post
      end
    end
  end

  def new
    @contributor = Contributor.new
    render :new
  end

  def create
    @contributor = Contributor.new(contributor_params)
    @user = User.find(@contributor.user_id)
   
    if params[:contributor][:image]
      @contributor.image.attach(params[:contributor][:image])
    end

    if @contributor.save
      redirect_to index_post_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contributor = Contributor.find_by(user_id: current_user.id)
    render :edit
  end

  def update
    @contributor = Contributor.find_by(user_id: current_user.id)
    
    if params[:contributor][:image]
      @contributor.image.attach(params[:contributor][:image])
    end
    
    if @contributor.update(contributor_params)
      redirect_to index_post_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @contributor = Contributor.find(@post.contributor_id)
    render :show
  end

  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.destroy
    redirect_to index_post_path, notice: '投稿者アカウントを削除しました'
  end

  private
  def contributor_params
    params.require(:contributor).permit(:name, :self_introduction, :image).merge(user_id: current_user.id)
  end

end
