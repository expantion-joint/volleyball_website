class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :show_terms_of_use]


  def index

    @address = params[:address]
    @club_name = params[:club_name]
    @category = params[:category]
    @posts_address = []
    @posts_address_club_name = []
    @posts_address_club_name_category = []

    # 開催日順に並び替え
    @posts_all = Post.all.order(event_date: :asc)

    # 住所で絞り込み
    if @address == "---" || @address.blank?
      @posts_address = @posts_all
    else
      @posts_address = @posts_all.where('address LIKE ?', "%#{@address}%")
    end
    
    # サークル名で絞り込み
    if @club_name == "---" || @address.blank?
      @posts_address_club_name = @posts_address
    else
      @posts_address.each do |post|
        if post.club_name == @club_name
          @posts_address_club_name << post
        end
      end
    end

    # カテゴリで絞り込み
    if @category == "---" || @address.blank?
      @posts_address_club_name_category = @posts_address_club_name
    else
      @posts_address_club_name.each do |post|
        if post.category == @category
          @posts_address_club_name_category << post
        end
      end
    end
    
    @posts = @posts_address_club_name_category

    @orders = Order.all
    @informations = Information.all
    @remaining_array = []
    @open_informations = []

    # 募集人数 - 予約数 ＝ 残り
    @posts.each do |post|
      total = 0
      @orders.each do |order|
        if order.post_id == post.id
          total = total + order.number_of_orders
        end
      end
      remaining = post.recruitment_numbers - total
      @remaining_array << remaining
    end

    @informations.each do |information|
      if information.public_or_private == "公開"
        @open_informations << information
      end
    end

    # 選択肢作成
    @clubs = ["---"]
    @categories = ["---"]

    @posts.each do |post|
      result_club = ""
      result_category = ""
      @clubs.each do |club|
        if post.club_name == club
          result_club = "duplicate"
        end
      end
      @categories.each do |category|
        if post.category == category
          result_category = "duplicate"
        end
      end
      
      if post.posting_start_time < Time.zone.now
        if post.posting_end_time > Time.zone.now
          if result_club != "duplicate"
            @clubs << post.club_name
          end 
          if result_category != "duplicate"
            @categories << post.category
          end
        end
      end
    end

    render :index

  end
  
  def new
    @user = User.find(current_user.id)
    @contributor = Contributor.find_by(user_id: current_user.id)

    if @user.usertype > 20
      @post = Post.new
      render :new
    else
      redirect_to index_post_path
    end
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(current_user.id)
    @contributor = Contributor.find_by(user_id: current_user.id)
    @post.contributor_id = @contributor.id
   
    if params[:post][:image]
      @post.image.attach(params[:post][:image])
    end

    if @user.usertype > 20
      if @post.save
        redirect_to index_post_path, notice: '投稿しました'
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)
    @orders = Order.all

    total = 0
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    @total = total

    if @user.usertype > 20
      render :edit
    else
      redirect_to index_post_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)

    if @user.usertype > 20
      if params[:post][:image]
        @post.image.attach(params[:post][:image])
      end
      if @post.update(post_params)
        redirect_to index_contributor_path, notice: '更新しました'
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to index_post_path
    end
  end

  def destroy
    @user = User.find(current_user.id)
    
    if @user.usertype > 20
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to index_post_path, notice: '削除しました'
    else
      redirect_to index_post_path
    end

  end

  def show
    @post = Post.find(params[:id])
    @contributor = Contributor.find(@post.contributor_id)
    @order = Order.new
    @orders = Order.all
    total = 0
    
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = User.new
      @user.usertype = 11
    end

    # 募集人数 - 予約数 ＝ 残り
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    @remaining = @post.recruitment_numbers - total

    render :show
  end

  def index_reservation_holder
    all_posts = Post.all
    @user = User.find(current_user.id)
    @posts = []

    if @user.usertype > 20
      if @user.usertype > 80
        all_posts.each do |post|
          @posts << post
        end
        render :index_reservation_holder
      else
        all_posts.each do |post|
          @contributor = Contributor.find(post.contributor_id)
          if @contributor.user_id == current_user.id
            @posts << post
          end
        end
        render :index_reservation_holder
      end
    else
      redirect_to index_post_path
    end
  end

  def show_reservation_holder
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)
    all_orders = Order.all
    @payment_price = 0
    @number_of_participants = 0
    @users = []
    @orders = []

    if @user.usertype > 20
      all_orders.each do |order|
        if order.post_id == @post.id
          @users << User.find(order.user_id)
          @orders << order

          payment_price = @payment_price
          @payment_price = order.results * @post.price + payment_price

          number_of_participants = @number_of_participants
          @number_of_participants = order.results + number_of_participants
        end
      end
      render :show_reservation_holder
    else
      redirect_to index_post_path
    end
  end

  def show_terms_of_use
    render :show_terms_of_use
  end

  def index_new_copy
    all_posts = Post.all
    @user = User.find(current_user.id)
    @posts = []

    if @user.usertype > 20
      all_posts.each do |post|
        @contributor = Contributor.find(post.contributor_id)
        if @contributor.user_id == current_user.id
          @posts << post
        end
      end
      render :index_new_copy
    else
      redirect_to index_post_path
    end
  end

  def new_copy
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)

    if @user.usertype > 20
      render :new_copy
    else
      redirect_to index_post_path
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :event_date, :venue, :event_start_time, :event_end_time, :posting_start_time, :posting_end_time, :address, :recruitment_numbers, :content, :price, :category, :instagram_url, :line_url, :facebook_url, :youtube_url, :note_url, :x_url, :club_name, :image)
  end
  
end
