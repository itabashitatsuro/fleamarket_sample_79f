class ItemsController < ApplicationController
  require "payjp"
  before_action :set_product, only: [:edit, :update, :destroy, :show, :purchase, :pay]

  def index
    @items = Item.includes(:image).all.order('created_at DESC') #トップページに表示、更新した順番で
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
    item= Item.find(params[:id])
    @images = @item.images.all
    
    Payjp.api_key = "sk_test_c806e554d011ef961a9f1ea5"
    @card = CreditCard.find_by(user_id: current_user.id)
    @customer = Payjp::Customer.retrieve(@card.customer_id)
    @customer_card = @customer.cards.retrieve(@card.card_id)
    @card_brand = @customer_card.brand
    case @card_brand
    when "Visa"
      @card_src = "visa.gif"
    when "JCB"
      @card_src = "jcb.gif"
    when "MasterCard"
      @card_src = "master.png"
    when "Discover"
      @card_src = "discover.gif"
    end
    
    @exp_month = @customer_card.exp_month.to_s
    @exp_year = @customer_card.exp_year.to_s.slice(2,3)
  end

  def pay
    @card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = "sk_test_c806e554d011ef961a9f1ea5"
    
    charge = Payjp::Charge.create(
      :amount => @item.price,
      :customer => @card.customer_id,
      :currency => 'jpy',
    )

    @item.update(buyer_id: current_user.id)
    redirect_to root_path, notice: '購入しました'
  end

  def list
    if params[:category_id].present?
      @items = Item.where(category_id: params[:category_id])
      @category = Category.find(params[:category_id])
      @num = 1
    else 
      @num = 2
      @items = Item.where(user_id: params[:user_id])
    end
    @parents = Category.where(ancestry: nil)
    @page_items = @items.paginate(page: params[:page], per_page: 15)
    
    # カテゴリ抽出
    # @items = Item.all
    # @category_items = []
    # @items.each do |item|
    #   if item.category_id == params[:category_id]
    #     @category_items.push(item)
    #   end
    # end
  end

  def edit
    @item.images.new
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
    params.require(:item).permit(:name, :price, :prefecture_id, :shipping_date_id , :category_id, :delivery_fee_id, :status_id, :introduction, :brand, :buyer_id, :seller_id, images_attributes: [:item_image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_product
    @item = Item.find(params[:id])
  end

end
