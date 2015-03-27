
def sign_in
  create_user
  visit root_path
  click_on 'Sign In'
  expect(current_path).to eq sign_in_path
  fill_in :email, with: @user.email
  fill_in :password, with: @user.password
  within("form") {click_on 'Sign In'}
end

def owner_count(project)
  project.memberships.where(role:1).count
end
