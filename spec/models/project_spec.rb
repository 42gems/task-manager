require 'rails_helper'

RSpec.describe Project, :type => :model do
  subject(:project) { Project.new title: 'project' }

  it "valid with title" do
    expect(project).to be_valid
  end

  it "is valid with description length < 255 characters" do
    project.description = "definitely higher" * 20
    project2 = Project.new title: 'project2', description: '12345'
    expect(project).to_not be_valid
    expect(project2).to be_valid
  end
end
