class CreditCardsController < ApplicationController
  require 'payjp'
  
  def new
    # @card = CreditCard.where(user_id: current_user.id)
    # if @card.exists?
    #   redirect_to credit_card_path(current_user.id)
    # end
  end

  def create
    Payjp.api_key = "sk_test_c806e554d011ef961a9f1ea5"
    
    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
      customer = Payjp::Customer.create(
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
    
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to credit_card_path(@card), notice: "クレジットカードの登録が完了しました"
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = "sk_test_c806e554d011ef961a9f1ea5"
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)

      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "MasterCard"
        @card_src = "master.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy 
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = "sk_test_c806e554d011ef961a9f1ea5"
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      if @card.destroy
      else
        redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:user_id, :customer_id, :card_id).merge(user_id: current_user.id)
  end

end

