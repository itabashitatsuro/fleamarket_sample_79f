class ItemsController < ApplicationController

  before_action :set_product, only: [:edit, :update, :destroy, :show, :purchase]

  def index
    @items = Item.includes(:images).order('created_at DESC') #トップページに表示、更新した順番で
    @items = Item.includes(:user).order("created_at DESC").limit(4)
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @category = Category.find(@item.category_id)
    @user = User.find(@item.user_id)
  end

  def new
    @item = Item.new
    @item.images.new

    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)

  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path, notice: "出品が完了しました"
    else
      render :new
    end
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end


  def purchase
    
    # if user_signed_in?
    #   @user = current_user
    #   if @user.credit_card.present?
    #     Payjp.api_key = Rails.application.credentials.dig(:payjp)
    #     @card = CreditCard.find_by(user_id: current_user.id)
    #     customer = Payjp::Customer.retrieve(@card.customer_id)
    #     @customer_card = customer.cards.retrieve(@card.card_id)

    #     @card_brand = @customer_card.brand
    #     case @card_brand
    #     when "Visa"
    #       @card_src = "visa.gif"
    #     when "JCB"
    #       @card_src = "jcb.gif"
    #     when "MasterCard"
    #       @card_src = "master.png"
    #     when "American Express"
    #       @card_src = "amex.gif"
    #     when "Diners Club"
    #       @card_src = "diners.gif"
    #     when "Discover"
    #       @card_src = "discover.gif"
    #     end
        
    #     @exp_month = @customer_card.exp_month.to_s
    #     @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    #   else
    #   end
    # else
    #   render :new
    # end
  end
  
  def pay
    @item = Item.find(item_params[:item_id])
    @images = @item.images.all

    #２重で決済されることを防ぐ
    if @item.purchase.present?
      redirect_to item_path(@item.id), alert: "すでに購入済み"
    else
      render 'credit_cards/edit'
    end
  end

  def edit
  end

  def update
    if
      @item.update(item_params)
      redirect_to user_path, notice: "出品情報の編集が完了しました"
    else
      flash.now[:alert] = "変更情報を入力してください"
      render 'items/edit'
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path 
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :prefecture_id, :shipping_date_id , :category_id, :delivery_fee_id, :status_id, :introduction, :brand, images_attributes: [:item_image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_product
    @item = Item.find(params[:id])
  end


end
