class ItemsController < ApplicationController
  require "payjp"
  
  def index
  end
  
  def purchase
  end

  def buy
    @item = Item.find(params[:item_id])
    @images = @item.images.all # 商品ごとの複数枚写真を取得
    
    if user_signed_in? # ログイン
      @user = current_user
      if @user.credit_card.present? # クレカが登録されているか確認
        # API秘密鍵を呼び出し
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :sk_test_c806e554d011ef961a9f1ea5)
        # ログインユーザーのクレカ情報を呼び出し
        @card = CreditCard.find_by(user_id: current_user.id)
        # ログインユーザーのクレカ情報をもとにPay.jpに登録されているカスタマー情報を引き出す
        customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
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
    @item = Item.find(params[:item_id])
    @images = @item.images.all

    # 購入テーブル登録ずみ商品は２重で購入されないようにする(２重で決済されることを防ぐ)
    if @item.purchase.present?
      redirect_to item_path(@item.id), alert: "すでに購入済み"
    else
      # 2人が同時に購入し、二重で購入処理がされることを防ぐ
      @item.with_lock do
        if current_user.credit_card.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張る。
          @card = CreditCard.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :sk_test_c806e554d011ef961a9f1ea5)
          charge = Payjp::Charge.create(
          # 商品(item)の値段を引っ張ってきて決済金額(amount)に入れる
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理
      @item = Item.create(customer_id: current_user.id, item_id: params[:item_id])
    end
  end
  
  def new
  end

  def test
  end
end
