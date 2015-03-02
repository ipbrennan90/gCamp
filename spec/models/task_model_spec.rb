require 'rails_helper'


describe Task do

  it 'is valid with a description' do
    task = Task.create(description: "test description", due_date: '2015-03-04')
    task.valid?
    expect(task).to be_valid
  end

  it 'is invalid without a description' do
    task = Task.create(description: "", due_date: '2015-03-04')
    expect(task.errors[:description]).to include("can't be blank")
  end

end
