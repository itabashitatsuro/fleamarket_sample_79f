class AddressesController < ApplicationController
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @item= Item.find(session[:item_id])
    if @address.save
      redirect_to purchase_item_path(@item.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
  
  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :house_number, :apartment, :contact, :family_name, :first_name, :family_name_kana, :first_name_kana).merge(user_id: current_user.id)
  end

end
# /address/new
# buy -> address -> buy
# URI(request.referer).path