class ItemsController < ApplicationController

  def index
    @parents = Category.where(ancestry: nil)
  end

  def purchase
  end
  def new
  end

  def test
  end
end
