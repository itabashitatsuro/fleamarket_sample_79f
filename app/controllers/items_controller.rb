class ItemsController < ApplicationController
  
  
  def index
  end

  def new
  end
  
  # 購入機能
  require "payjp"

  def purchase
    @item = Item.find(item_params[:item_id])
    @images = @item.images.all
    
    if user_signed_in?
      @user = current_user
      if @user.credit_card.present?
        Payjp.api_key = Rails.application.credentials.dig(:payjp)
        @card = CreditCard.find_by(user_id: current_user.id)
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)

        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          @card_src = "visa.gif"
        when "JCB"
          @card_src = "jcb.gif"
        when "MasterCard"
          @card_src = "master.png"
        when "American Express"
          @card_src = "amex.gif"
        when "Diners Club"
          @card_src = "diners.gif"
        when "Discover"
          @card_src = "discover.gif"
        end
        
        @exp_month = @customer_card.exp_month.to_s
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end


  def pay
    @item = Item.find(item_params[:item_id])
    @images = @item.images.all

    #２重で決済されることを防ぐ
    if @item.purchase.present?
      redirect_to item_path(@item.id), alert: "すでに購入済み"
    else
      @item.with_lock do
        if current_user.credit_card.present?
          @card = CreditCard.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp)
          charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'],
          currency: 'jpy'
          )
        end
      end
    end
  end

  private

  def item_params
    params.require(:item).permit(:user, :name, :price, :introduction, :status, :prefecture, :postage, :shipping_date_id, :delivery_fee, :area, :category, :item_image).merge(user_id: current_user.id)
  end
end
