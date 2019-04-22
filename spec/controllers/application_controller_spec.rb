require 'rails_helper'

describe ApplicationController do

    it 'Check for admin when not admin' do
        user = User.create!(user_attributes(admin: false))
        session[:user_id] = user.id

        require_admin
        expect(response).to redirect_to(root_url)
        
        
      end

end
