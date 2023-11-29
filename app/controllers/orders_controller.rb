class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    all_orders = Order.all
    @posts = []
    @orders = []

    all_orders.each do |order|
      if order.user_id == current_user.id
        @posts << Post.find(order.post_id)
        @orders << order
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @post = Post.find(params[:id])
    @orders = Order.all
    total = 0

    # 募集人数 - 予約数 ＝ 残り
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    # 予約済みかどうかの確認
    @orders.each do |order|
      if order.post_id == @post.id
        if order.user_id == current_user.id
          @appointment = "true"
        end
      end
    end

    @remaining = @post.recruitment_numbers - total - @order.number_of_orders

    if @remaining < 0
      redirect_to show_post_path(params[:id]), notice: '予約人数が募集人数を超えています'
    else
      if @appointment == "true"
        redirect_to show_post_path(params[:id]), notice: '既に予約済みです'
      else
        if @order.save
          redirect_to show_post_path(params[:id]), notice: '予約しました'
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    @order_params = Order.new(order_params)
    @orders = Order.all
    total = 0

    @orders.each do |order|
      if order.user_id == current_user.id
        if order.post_id == @post.id
          @order = order
        end
      end
    end

    # 募集人数 - 予約数 ＝ 残り
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    @remaining = @post.recruitment_numbers - total - @order_params.number_of_orders + @order.number_of_orders

    if @remaining < 0
      redirect_to show_order_path(params[:id]), notice: '予約人数が募集人数を超えています'
    else
      if @order.update(order_params)
        redirect_to show_order_path(params[:id]), notice: '予約人数を変更しました'
      else
        render :show, status: :unprocessable_entity
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @contributor = Contributor.find(@post.contributor_id)
    @orders = Order.all
    total = 0

    @orders.each do |order|
      if order.user_id == current_user.id
        if order.post_id == @post.id
          @order = order
        end
      end
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

  private
  def order_params
    params.require(:order).permit(:number_of_orders).merge(post_id: params[:id], user_id: current_user.id)
  end

end
