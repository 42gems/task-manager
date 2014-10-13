require 'rails_helper'

RSpec.describe User, :type => :model do
  subject(:user) { User.new email: 'user@example.com', password: 'password' }

  it "is valid with email and password" do
    expect(user).to be_valid
  end

  it "is invalid with a duplicated emails" do
    user.save
    user2 = User.new email: 'user@example.com', password: 'password'
    expect(user2).to_not be_valid
  end

  context "can_manage? instance method" do
    before :example do 
      user.save
      @p = user.projects.build(title: 'test')
      @p.save
    end

    it "defined" do
      expect(User.instance_methods.include?(:can_manage?)).to eq true
    end

    it "return true if user is owner of the project" do
      user.save
      expect(user.can_manage?(@p)).to eq true
    end

    it "return true if user is a member of a project" do
      user2 = User.create email: 'user2@example.com', password: 'password'
      @p.members << user2
      expect(user2.can_manage?(@p)).to eq true
    end
  end
end
