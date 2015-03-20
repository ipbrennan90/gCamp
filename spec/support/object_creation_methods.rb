def create_user
  @user1 = User.create!(first_name: 'first', last_name: 'last', email: 'email@mail.com',
  password: 'securepass', password_confirmation: 'securepass', permission: 0)
end

def create_user_duo
  @user1 = User.create(first_name: 'first', last_name: 'last', email: 'email@mail.com',
  password: 'securepass', password_confirmation: 'securepass', permission: 0)
  @user2 = User.create(first_name: 'first1', last_name: 'last1', email: 'email1@mail.com',
  password: 'securepass1', password_confirmation: 'securepass1', permission: 0)

end

def create_users
  User.destroy_all
  pass = Faker::Internet.password
  @user_admin = User.create(first_name:"Adam", last_name: "Admin", email: "adam.admin@daboss.com", password: "adminpass", password_confirmation: "adminpass", permission: 1)
  @usercollection=20.times.map{User.create!(first_name:"#{Faker::Name.first_name}", last_name:"#{Faker::Name.last_name}", email: "#{Faker::Internet.email}",
  password: "#{pass}", password_confirmation: "#{pass}", permission: 0)}
end

def new_project
  @project1 = Project.create(name: 'Test Project')
end

def new_memberships(project)
  create_user_duo
  project.memberships.create!(role: 1, project_id: @project1.id, user_id: @user1.id )
  project.memberships.create!(role: 2, project_id: @project1.id, user_id: @user2.id )
end
