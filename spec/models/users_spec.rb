require 'rails_helper'

describe User do
  before do
    @user = User.create(first_name: 'first', last_name: 'last', email: 'email@mail.com',
    password: 'securepass', password_confirmation: 'securepass')
  end

  it 'is valid with a first name, last name, email, password, and password_confirmation' do
    @user.valid?
    expect(@user).to be_valid
  end

  it 'is invalid without a first name' do
    @user.update_attributes(first_name: nil)
    expect(@user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    @user.update_attributes(last_name: nil)
    expect(@user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    @user.update_attributes(email: nil)
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    user1 = User.create(first_name: 'firstest', last_name: 'lastest', email: 'email@mail.com',
    password: 'curepass')
    expect(user1.errors[:email]).to include("has already been taken")
  end

  it 'is invalide without a password' do
    @user.update_attributes(password: nil)
    expect(@user.errors[:password]).to include("can't be blank")
  end

end
