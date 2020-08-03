class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.create(user_registration_params)
    @nickname = current_user.nickname
  end


  def edit
  end

  def update
  end

  def show
  end
#    user = User.find(params[:id])
#    @nickname = user.nickname
#    @items = user.items
#    @favorites = user.favorites
#    @profile = user.profile
#    @addresses = user.addresses
#    @buyer_items = user.buyer_items
#    @saling_items = user.saling_items
#    @sold_items = user.sold_items

  # def login
  # end

  private
  def user_registration_params
    params.require(:user).permit(:nickname, :email, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end


end
