require 'rails_helper'

describe SessionsController do

  it "Sign in and out" do
    user = User.create!(user_attributes)
    post(:create, session: {'user_id' => user.id})
    expect(session[:user_id]).to eq(user.id)
    delete :destroy
    expect(session[:user_id]).to eq(nil)

  end

end
