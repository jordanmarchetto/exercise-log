require 'rails_helper'

RSpec.describe RecordsController, type: :controller do
  let(:exercise1) { FactoryBot.create(:exercise, name: "Deadlift RecordsController", show_on_records: true) }
  let(:exercise2) { FactoryBot.create(:exercise, name: "Squat RecordsController", show_on_records: true) }
  let!(:weight_workout_set1) { FactoryBot.create(:weight_workout_set, exercise: exercise1, rep_value: 200, created_at: 2.days.ago) }
  let!(:weight_workout_set2) { FactoryBot.create(:weight_workout_set, exercise: exercise2, rep_value: 300, created_at: 1.day.ago) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns exercises that are tracked for records" do
      get :index
      expect(assigns(:exercises)).to match_array([exercise1, exercise2])
    end

    it "calculates real and estimated totals" do
      get :index
      totals = assigns(:totals)
      expect(totals[:real_total]).to eq(500) # 300 + 200
      expect(totals[:estimated_total]).to eq(583) # 349 + 233 (5 reps of 200/300)
    end

    it "builds chart data" do
      allow(controller).to receive(:build_chart_data).and_return([{:name=>"Deadlift", :color=>"#FF6384", :data=>{2.days.ago.to_date => 200}}, {:name=>"Squat", :color=>"#36A2EB", :data=>{1.day.ago.to_date => 300}}])
      get :index
      expect(assigns(:chart_data)).to eq([{:name=>"Deadlift", :color=>"#FF6384", :data=>{2.days.ago.to_date => 200}}, {:name=>"Squat", :color=>"#36A2EB", :data=>{1.day.ago.to_date => 300}}])
    end
  end
end
