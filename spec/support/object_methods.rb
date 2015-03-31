
def sign_in(user)
  visit root_path
  click_on 'Sign In'
  fill_in :email, with: user.email
  fill_in :password, with: user.password
  within("form") {click_on 'Sign In'}
end

def owner_count(project)
  project.memberships.where(role:1).count
end
