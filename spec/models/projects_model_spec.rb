require 'rails_helper'


describe Project do



  it 'is valid with a name' do
    new_project
    @project1.valid?
    expect(@project1).to be_valid
  end

  it 'is invalid without a name' do
    new_project
    @project1.update_attributes(name: '')
    expect(@project1.errors[:name]).to include ("can't be blank")
  end

end
