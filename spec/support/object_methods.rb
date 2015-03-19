
def sign_in
  @user1 = User.create(first_name: 'first', last_name: 'last', email: 'email@mail.com',
  password: 'securepass', password_confirmation: 'securepass')
  visit root_path
  click_on 'Sign In'
  expect(current_path).to eq sign_in_path
  fill_in :email, with: @user1.email
  fill_in :password, with: @user1.password
  within("form") {click_on 'Sign In'}
end

def owner_count(project)
  project.memberships.where(role:1).count
end
