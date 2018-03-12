require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "render a new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context 'when provided with valid parameters' do

      it "redirects to root url" do
        post :create, params: {user:  { username: 'frank', password: 'password' } }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when provided with invalid parameters' do

      it 'renders new form' do
        post :create, params: { user: { username: 'frank', password: '' } }
        expect(response).to render_template(:new)
      end
    end

  end

end
