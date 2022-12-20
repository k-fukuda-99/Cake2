class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  # カート内一覧
  def index
    @cart_items = current_customer.cart_items.all
  end

  # カート内に商品追加
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount = params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      render 'index'
    else
      render 'index'
    end
  end

  # カート内更新
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  # カート内の商品１つのみ削除
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end
# カート内全て削除
  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :price, :amount)
  end


#  before_action :authenticate_customer!

#  def index
#    @cart_items = CartItem.where(customer_id: current_customer.id)
#  end

#  def create
#    @cart_item_check = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
#    if @cart_item_check
#      @cart_item_check.amount += params[:cart_item][:amount].to_i
#      @cart_item_check.save
#      flash[:success] = "カートに存在済のアイテムです"
#      redirect_to cart_items_path
#    else
#      @cart_item = CartItem.new(cart_item_params)
#      @cart_item.customer_id = current_customer.id
#      if @cart_item.save
#        @cart_items = current_customer.cart_items.all
#        flash[:success] = "カートに追加しました"
#        redirect_to cart_items_path
#      else
#        flash[:danger] = "予期せぬエラーが発生しました"
#        redirect_back(fallback_location: root_path)
#      end
#    end
#  end

#  def update
#    @cart_item = CartItem.find(params[:id])
#    if @cart_item.update(cart_item_params)
#      flash[:success] = "個数を変更しました"
#      redirect_back(fallback_location: root_path)
#    else
#      flash[:danger] = "正しい個数を入力してください"
#      redirect_back(fallback_location: root_path)
#    end
#  end

#  def destroy_all
#    CartItem.where(customer_id: current_customer.id).destroy_all
#    flash[:success] = "カートの中身を空にしました"
#    redirect_back(fallback_location: root_path)
#  end

#  def destroy
#    @cart_item = CartItem.find(params[:id])
#    @cart_item.destroy
#    flash[:success] = "選択いただいたカートを空にしました"
#    redirect_back(fallback_location: root_path)
#  end


#  private

#  def cart_item_params
#    params.require(:cart_item).permit(:item_id, :amount)
#  end

end
