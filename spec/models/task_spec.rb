require 'rails_helper'

RSpec.describe Task, :type => :model do
  subject(:task) { Task.new title: 'task' }

  it "is valid with the title" do
    expect(task).to be_valid
  end

  it "changes state to 'new' after initialize" do
    expect(task.state).to eq 'new'
  end

  it "has STATES constant with 'new', 'in_progress', 'done', 'approved' values" do
    expect(Task::STATES.values).to eq ['new', 'in progress', 'done', 'approved']
  end

  it "is valid with states: 'new', 'in progress', 'done', 'approved'" do
    Task::STATES.values.each do |value|
      task = Task.new(title: '#{value} task', state: value)
      expect(task).to be_valid
    end
    invalid = Task.create title: 'invalid'
    invalid.state = 'yolo'
    expect(invalid).to_not be_valid
  end
end
