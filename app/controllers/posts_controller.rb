class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:top, :index]

  def top
    render :top
  end

  def index
    @posts = Post.all
    @orders = Order.all
    @remaining_array = []
    total = 0

    # 募集人数 - 予約数 ＝ 残り
    @posts.each do |post|
      @orders.each do |order|
        if order.post_id == post.id
          total = total + order.number_of_orders
        end
      end
      remaining = post.recruitment_numbers - total
      @remaining_array << remaining
    end
  end
  
  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @contributor = Contributor.find_by(user_id: current_user.id)
    @post.contributor_id = @contributor.id
   
    if params[:post][:image]
      @post.image.attach(params[:post][:image])
    end

    if @post.save
      redirect_to index_post_path, notice: '投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    
    if params[:post][:image]
      @post.image.attach(params[:post][:image])
    end
    
    if @post.update(post_params)
      redirect_to index_post_path, notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to index_post_path, notice: '削除しました'
  end

  def show
    @post = Post.find(params[:id])
    @contributor = Contributor.find(@post.contributor_id)
    @order = Order.new
    @orders = Order.all
    total = 0

    # 募集人数 - 予約数 ＝ 残り
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    @remaining = @post.recruitment_numbers - total

    render :show
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :event_date, :venue, :event_start_time, :event_end_time, :posting_start_time, :posting_end_time, :address, :recruitment_numbers, :content, :price, :category, :image)
  end
  
end
