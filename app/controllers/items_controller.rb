class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC') #トップページに表示、更新した順番で
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path
  end

  def purchase
  end

  def test
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :prefecture_id, :shopping_date_id , :introduction, :brand, images_attributes: [:item_image, :_destroy, :id])
  end
  
end
