require 'rails_helper'

describe ItemsController do
  describe 'GET #new' do
    # 正しいページに遷移しているか
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
    # 正しいページに遷移しているか
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end


  describe "#create" do
    #ログインしている
    context 'log in' do
      before do
        login user
      end
      #「product_params」をPOSTで送信する
      # 保存に成功した場合且つ、正しいページに遷移しているか
      context 'can save' do
        item_params = FactoryBot.attributes_for(:item)
        post :create, params: {item:item_params }
      end
      it "redirects to the root page" do
        expect(response).to render_template :index
      end
      
      # 保存は行われなかったかが、正しいページに遷移しているか
      context 'can not save' do
        item_params = FactoryBot.attributes_for(:item)
        post :create, params: {item:item_invalid_params }
      end
      it "redirects to the root page" do
        expect(response).to render_template :index
      end
    end
    # context 'not log in' do
    #   # ログインしていない場合且つ意図した画面にリダイレクトできているか
    #   it 'redirects to new_user_session_path' do
    #     post :create, params: params
    #     expect(response).to redirect_to(new_user_session_path)
    #   end
    # end
  end

end