class CreditCardsController < ApplicationController
  require 'payjp'
  
  def new # すでにクレジットカード登録されている場合は、showアクションにリダイレクト
    @card = CreditCard.where(user_id: current_user.id)
    redirect_to credit_card_path(current_user.id) if @card.exists?
  end

  def create
    # API秘密鍵を呼び出す
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :sk_test_c806e554d011ef961a9f1ea5)

    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
    # 生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
      # トークン化した情報をCredit_cardsテーブルに登録
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      # トークン作成とともにcredit_cardsテーブルに登録された場合、createビューが表示されるように条件分岐
      if @card.save
      else
       redirect_to action: "create"
      end
    end
  end

  def show
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
    # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
    # API秘密鍵を呼び出す
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :sk_test_c806e554d011ef961a9f1ea5)
    # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
    # カスタマー情報からカードの情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id)

    #カードのアイコン表示のための定義づけ
      @card_brand = @customer_card.brand
      case @card_brand
    # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
    # (画像として登録されている)Visa.pngを返す
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "master.png"
      when "American Express"
        @card_src = "amex.png"
      when "Diners Club"
        @card_src = "diners.png"
      when "Discover"
        @card_src = "discover.png"
      end
      # viewの記述を簡略化
      # 有効期限'月'を定義
      @exp_month = @customer_card.exp_month.to_s
      # 有効期限'年'を定義
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
    # 未登録なら新規登録画面に
      redirect_to action: "new"
    else
    # API秘密鍵を呼び出す
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :sk_test_c806e554d011ef961a9f1ea5)
    # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
    # そのカスタマー情報を消す
      customer.delete
      @card.delete
    # 削除が完了しているか判断
      if @card.destroy
    # 削除完了していればdestroyのビューに移行
      else
    # 削除されなかった場合flashメッセージを表示させて、showのビューに移行
        redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end
  
end
