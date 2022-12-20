class Public::AddressesController < ApplicationController

  def index
    @address = Address.new
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def create
    @address = gAddress.new(shipping_address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "新しい配送先の登録が完了しました。"
      redirect_to addresses_path
    else
      @customer = current_customer
      @addresses = @customer.addresses
      flash[:danger] = "新しい配送先内容に不備があります。"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
       flash[:success] = "配送先の変更内容を保存しました。"
       redirect_to addresses_path
    else
       flash[:danger] = "配送先の変更内容に不備があります。"
       redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.destroy
    flash[:success] = "配送先の削除が完了しました。"
    redirect_to addresses_path
  end


  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
