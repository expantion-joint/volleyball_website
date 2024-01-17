class ContributorsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def index
    all_posts = Post.all
    user = User.find(current_user.id)
    @posts = []

    if user.usertype > 90
      all_posts.each do |post|
        @posts << post
      end
      render :index
    else
      if user.usertype > 20
        all_posts.each do |post|
          @contributor = Contributor.find(post.contributor_id)
          if @contributor.user_id == current_user.id
            @posts << post
          end
        end
        render :index
      else
        redirect_to index_post_path
      end
    end
  end

  def new
    @user = User.find(current_user.id)
    if @user.usertype > 20
      @contributor = Contributor.new
      render :new
    else
      redirect_to index_post_path
    end
  end

  def create
    @contributor = Contributor.new(contributor_params)
    @user = User.find(@contributor.user_id)
    user = User.find(current_user.id)
   
    if params[:contributor][:image]
      @contributor.image.attach(params[:contributor][:image])
    end

    if user.usertype > 20 
      if @contributor.save
        redirect_to index_post_path, notice: '登録しました'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def edit
    @user = User.find(current_user.id)
    if @user.usertype > 20 
      @contributor = Contributor.find_by(user_id: current_user.id)
      render :edit
    else
      redirect_to index_post_path
    end
  end

  def update
    @contributor = Contributor.find_by(user_id: current_user.id)
    @user = User.find(current_user.id)

    if params[:contributor][:image]
      @contributor.image.attach(params[:contributor][:image])
    end
    
    if @user.usertype > 20 
      if @contributor.update(contributor_params)
        redirect_to index_post_path, notice: '更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @contributor = Contributor.find(@post.contributor_id)
    render :show
  end

  def destroy
    @contributor = Contributor.find(params[:id])
    user = User.find(current_user.id)
    if user.usertype > 20 
      @contributor.destroy
      redirect_to index_post_path, notice: '投稿者アカウントを削除しました'
    else
      redirect_to index_post_path
    end
  end

  private
  def contributor_params
    params.require(:contributor).permit(:name, :self_introduction, :club_name1, :club_name2, :club_name3, :club_name4, :club_name5, :image).merge(user_id: current_user.id)
  end

end
