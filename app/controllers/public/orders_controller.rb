class Public::OrdersController < ApplicationController

  include Public::OrdersHelper
  before_action :authenticate_customer!
  before_action :cart_check, only: [:new, :confirm, :create]

  def cart_check
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品がない状態です"
      redirect_to root_url
    end
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800
    # 会員の住所の表示
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      render :confirm
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.postal_code = @order.postal_code
      @order.address = @order.address
      @order.name = @order.name
    else
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price * 1.1
        order_detail.making_status = 0
        if order_detail.save
          @cart_items.destroy_all
        end
      end
      redirect_to orders_thanks_path
    else
    end
  end

  def thanks
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  private

  def order_params
    params.require(:order).permit(:shipping_cost, :payment_method, :name, :address, :postal_code ,:customer_id, :total_payment, :status)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
