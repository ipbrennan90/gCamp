def create_user
  User.create!(first_name: "test", last_name: "tested", email: "test@test.com", password: "password", password_confirmation: "password", permission: false, pivotal_tracker_token: "652dfc58f4f25cd5bfc7ecbd6f303245")
end

def create_user_duo
  @user2 = User.create!(first_name: 'first', last_name: 'last', email: 'email2@mail.com',
  password: 'securepass', password_confirmation: 'securepass')
  @user1 = User.create!(first_name: 'first1', last_name: 'last1', email: 'email1@mail.com',
  password: 'securepass1', password_confirmation: 'securepass1')

end

def create_users
  User.destroy_all
  pass = Faker::Internet.password
  @user_admin = User.create(first_name:"Adam", last_name: "Admin", email: "adam.admin@daboss.com", password: "adminpass", password_confirmation: "adminpass", permission: 1)
  @usercollection=20.times.map{User.create!(first_name:"#{Faker::Name.first_name}", last_name:"#{Faker::Name.last_name}", email: "#{Faker::Internet.email}",
  password: "#{pass}", password_confirmation: "#{pass}")}
end

def create_project
  Project.create!(name: "ProjectTest")
end

def new_project
  @project1 = Project.create!(name: 'Test Project')
  @project1.memberships.create!(role:1, user_id: @user.id)
end

def owner_membership
  Membership.create!(project_id: project.id, user_id: user.id, role: 1 )
end

def member_membership
  Membership.create!(project_id: project.id, user_id: user.id, role: 2)
end


def new_memberships(project)
  create_user_duo
  project.memberships.create!(role: 1, project_id: project.id, user_id: @user.id )
  project.memberships.create!(role: 2, project_id: project.id, user_id: @user2.id )
end

def create_task
  project.tasks.create!(description: 'Test Task', due_date: '2015-06-04')
end
