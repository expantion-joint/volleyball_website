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
    @contributor = Contributor.find(user_id: current_user.id)
    render :edit
  end

  def update
    @contributor = Contributor.find(user_id: current_user.id)
    
    if params[:contributor][:image]
      @contributor.image.attach(params[:contributor][:image])
    end
    
    if @contributor.update(contributor_params)
      redirect_to index_post_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def contributor_params
    params.require(:contributor).permit(:name, :self_introduction, :image).merge(user_id: current_user.id)
  end

end
