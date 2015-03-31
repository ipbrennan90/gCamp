require 'rails_helper'


describe Project do

  let(:project) {create_project}



  it 'is valid with a name' do
    project.valid?
    expect(project).to be_valid
  end

  it 'is invalid without a name' do
    project.update_attributes(name: '')
    expect(project.errors[:name]).to include ("can't be blank")
  end

end
