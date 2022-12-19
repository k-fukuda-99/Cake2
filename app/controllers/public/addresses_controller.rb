class Public::AddressesController < ApplicationController

  def index
    @shipping_address = ShippingAddress.new
    @customer = current_customer
    @shipping_addresses = @customer.shipping_addresses
  end

  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      flash[:success] = "新しい配送先の登録が完了しました。"
      redirect_to shipping_addresses_path
    else
      @customer = current_customer
      @shipping_addresses = @customer.shipping_addresses
      flash[:danger] = "新しい配送先内容に不備があります。"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
       flash[:success] = "配送先の変更内容を保存しました。"
       redirect_to shipping_addresses_path
    else
       flash[:danger] = "配送先の変更内容に不備があります。"
       redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address.customer_id = current_customer.id
    @shipping_address.destroy
    flash[:success] = "配送先の削除が完了しました。"
    redirect_to shipping_addresses_path
  end


  private
  def shipping_address_params
    params.require(:shipping_address).permit(:shipping_postcode, :shipping_address, :shipping_name)
  end

end
