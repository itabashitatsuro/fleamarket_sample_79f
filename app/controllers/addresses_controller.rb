class AddressesController < ApplicationController
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.create(address_params)
  #  binding.pry
    if @address.save
      redirect_to root_path
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
    params.require(:address).permit(:postal_code, :prefecture, :city, :house_number, :apartment, :contact)
  end

end
