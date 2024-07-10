require 'rails_helper'

RSpec.describe ExercisesController, type: :controller do
  let(:valid_attributes) {
    { name: "Bench Press ControllerTest", description: "Chest exercise", show_on_records: true, set_types: ["WeightWorkoutSet", "RepWorkoutSet"] }
  }

  let(:invalid_attributes) {
    { name: "", description: "Chest exercise", show_on_records: true, set_types: ["WeightWorkoutSet", "RepWorkoutSet"] }
  }

  let!(:exercise) { FactoryBot.create(:exercise) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(assigns(:exercises)).to eq([exercise])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: exercise.to_param }
      expect(response).to be_successful
      expect(assigns(:exercise)).to eq(exercise)
      expect(assigns(:sets)).to eq([])
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
      expect(assigns(:exercise)).to be_a_new(Exercise)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: exercise.to_param }
      expect(response).to be_successful
      expect(assigns(:exercise)).to eq(exercise)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Exercise" do
        expect {
          post :create, params: { exercise: valid_attributes }
        }.to change(Exercise, :count).by(1)
      end

      it "redirects to the created exercise" do
        post :create, params: { exercise: valid_attributes }
        expect(response).to redirect_to(Exercise.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Exercise" do
        expect {
          post :create, params: { exercise: invalid_attributes }
        }.to change(Exercise, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post :create, params: { exercise: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "PUT #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Squat" }
      }

      it "updates the requested exercise" do
        put :update, params: { id: exercise.to_param, exercise: new_attributes }
        exercise.reload
        expect(exercise.name).to eq("Squat")
      end

      it "redirects to the exercise" do
        put :update, params: { id: exercise.to_param, exercise: valid_attributes }
        expect(response).to redirect_to(exercise)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        put :update, params: { id: exercise.to_param, exercise: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested exercise" do
      expect {
        delete :destroy, params: { id: exercise.to_param }
      }.to change(Exercise, :count).by(-1)
    end

    it "redirects to the exercises list" do
      delete :destroy, params: { id: exercise.to_param }
      expect(response).to redirect_to(root_path)
    end
  end
end
