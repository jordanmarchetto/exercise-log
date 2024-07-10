# spec/controllers/recent_workouts_controller_spec.rb
require 'rails_helper'

RSpec.describe RecentWorkoutsController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end
end
