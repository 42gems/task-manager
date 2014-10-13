require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  describe 'GET #index' do
    it "assigns all project of current_user, in which he is member or owner, to the @projects"
    it "renders :index view"
  end

  describe 'GET #edit' do
    it "assigns members of the project to @members"
    it "renders :edit tamplate" do
      # user = FactoryGirl.build(:user)
      # project = user.projects.first
      # get :edit, id: project
      # expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes project from the database'
    it 'redirects to the :index action'
  end
end
