require 'rails_helper'

describe UsersController do

  describe 'GET#index' do
    it 'allows admin to view all users' do
      user =
