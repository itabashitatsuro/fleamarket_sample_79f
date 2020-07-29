require 'rails_helper'

describe ItemsController do
  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  # describe 'GET #edit' do
  #   it "assigns the requested item to @item" do
  #     item = create(:item)
  #     get :edit, params: { id: item}
  #     expect(assigns(:item)).to eq item
  #   end
    
  #   it "renders the :edit template" do
  #     item = create(:item)
  #     get :edit, params: { id: item}
  #     expect(response).to render_template :edit
  #   end
  # end

  describe 'GET #index' do
    it "populates an array of items ordered by created_at DESC" do
      items = create_list(:item, 3)
      get :index
      expect(assigns(:items)).to match(items.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "#create" do
    let(:user) {create(:user)}
    context "as a user login" do
      before do
        login user
          #「product_params」をPOSTで送信する
          item_params = FactoryBot.attributes_for(:item)
          post :create, params: {item:item_params }
      end
          # ルートパスにリダイレクトすること
        it "redirects to the root page" do
          # ルートパスに遷移することを確認
          expect(response).to be_successful
        end
    end
  end

end