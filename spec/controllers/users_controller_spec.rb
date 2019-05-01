require 'rails_helper'

describe UsersController do
  before do
    @user = User.create!(user_attributes)
  end

  context 'when not signed in' do
    it 'cannot access user list' do
      get :index
      expect(response).to redirect_to(new_session_path)
    end
    it 'cannot access user page' do
      get :show, params: { id: @user.id }
      expect(response).to redirect_to(new_session_path)
    end
  end

  context 'when not signed in as an admin user' do
    before do
      @non_admin = User.create!(user_attributes(email: 'nonadmin@email.com', admin: false))
      session[:user_id] = @non_admin.id
    end

    it 'cannot access other user update' do
      get :edit, params: { id: @user }

      expect(response).to redirect_to(root_url)
    end

    it 'cannot access other user update' do
      patch :update, params: { id: @user }

      expect(response).to redirect_to(root_url)
    end

    it 'cannot access other user destroy' do
      delete :destroy, params: { id: @user }

      expect(response).to redirect_to(root_url)
    end
  end
end
