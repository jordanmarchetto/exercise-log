require 'rails_helper'

RSpec.describe WorkoutSetsController, type: :controller do
  let(:exercise) { FactoryBot.create(:exercise) }
  let(:valid_attributes) {
    {
      exercise_id: exercise.id,
      rep_count: 10,
      rep_value: 100,
      rpe: 8,
      distance: 100,
      duration: 30.5,
      type: 'WeightWorkoutSet',
      created_at: Time.now
    }
  }

  let!(:workout_set) { FactoryBot.create(:weight_workout_set, exercise: exercise) }

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new WorkoutSet" do
        expect {
          post :create, params: valid_attributes
        }.to change(WorkoutSet, :count).by(1)
      end

      it "redirects to the exercise" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(exercise)
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { exercise_id: exercise.to_param, id: workout_set.to_param }
      expect(response).to be_successful
      expect(assigns(:set)).to eq(workout_set)
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { rep_count: 12, rep_value: 110 }
      }

      it "updates the requested workout set" do
        put :update, params: { exercise_id: exercise.to_param, id: workout_set.to_param, **new_attributes }
        workout_set.reload
        expect(workout_set.rep_count).to eq(12)
        expect(workout_set.rep_value).to eq(110)
      end

      it "redirects to the exercise" do
        put :update, params: { exercise_id: exercise.to_param, id: workout_set.to_param, **valid_attributes }
        expect(response).to redirect_to(exercise)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested workout set" do
      expect {
        delete :destroy, params: { exercise_id: exercise.to_param, id: workout_set.to_param }
      }.to change(WorkoutSet, :count).by(-1)
    end

    it "redirects to the exercise" do
      delete :destroy, params: { exercise_id: exercise.to_param, id: workout_set.to_param }
      expect(response).to redirect_to(exercise)
    end
  end
end
