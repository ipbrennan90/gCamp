require 'rails_helper'

describe UsersController do

  describe 'GET#index' do
    it 'populates an array of users' do
      users = create_users
      get :index
      expect(assigns(:users)).to eq [users]
    end
  end
end
