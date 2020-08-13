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
    @user = User.find_by(id: current_user.id)
    @items = Item.all
  end

  private
  def user_registration_params
    params.require(:user).permit(:id, :nickname, :email, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday)
  end

end
