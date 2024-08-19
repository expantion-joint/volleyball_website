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

    # 募集数 - 予約数 ＝ 残り
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
    @order.payment_status = "未払い"
    @order.results = 0

    if @remaining < 0
      flash[:alert] = "予約数が募集数を超えています"
      redirect_to show_post_path(params[:id])
    else
      if @appointment == "true"
        flash[:alert] = "既に予約済みです"
        redirect_to show_post_path(params[:id])
      else
        if @order.save
          redirect_to show_post_path(params[:id]), notice: '予約しました'
        else
          flash[:alert] = "予約に失敗しました"
          redirect_to show_post_path(params[:id])
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

    # 募集数 - 予約数 ＝ 残り
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    @remaining = @post.recruitment_numbers - total - @order_params.number_of_orders + @order.number_of_orders

    if @remaining < 0
      flash[:alert] = "予約数が募集数を超えています"
      redirect_to show_order_path(params[:id])
    else
      if @order.update(order_params)
        redirect_to show_order_path(params[:id]), notice: '予約数を変更しました'
      else
        flash[:alert] = "予約に失敗しました"
        redirect_to show_order_path(params[:id])
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

    # 募集数 - 予約数 ＝ 残り
    @orders.each do |order|
      if order.post_id == @post.id
        total = total + order.number_of_orders
      end
    end

    @remaining = @post.recruitment_numbers - total

    render :show
  end

  def update_reservation_holder
    @order = Order.find(params[:id])
    @order.payment_status = "支払済"
    user = User.find(current_user.id)

    if user.usertype > 20
      if @order.update(order_params_without_id)
        flash[:notice] = "登録しました"
        redirect_back(fallback_location: index_post_reservation_holder_path)
      else
        flash[:alert] = "登録に失敗しました"
        redirect_back(fallback_location: index_post_reservation_holder_path)
      end
    else
      redirect_to index_post_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:number_of_orders, :results, :payment_status).merge(post_id: params[:id], user_id: current_user.id)
  end

  def order_params_without_id
    params.require(:order).permit(:number_of_orders, :results, :payment_status)
  end

end
