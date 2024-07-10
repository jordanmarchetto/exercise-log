# spec/models/exercise_spec.rb
require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it "is valid with valid attributes" do
    exercise = FactoryBot.build(:exercise)
    expect(exercise).to be_valid
  end

  it "is not valid without a name" do
    exercise = FactoryBot.build(:exercise, name: nil)
    expect(exercise).to_not be_valid
  end

  it "is not valid without set_types" do
    exercise = FactoryBot.build(:exercise, set_types: [])
    expect(exercise).to_not be_valid
  end

  context "when exercise has associated weight workout sets" do
    let(:exercise) { FactoryBot.create(:exercise) }
    let!(:weight_workout_set) { FactoryBot.create(:weight_workout_set, exercise: exercise) }

    it "destroys associated workout sets when exercise is destroyed" do
      expect { exercise.destroy }.to change { WeightWorkoutSet.count }.by(-1)
    end
  end

  describe "weight_workout_sets" do
    context "when exercise has associated weight workout sets and other workout sets" do
      let(:exercise) { FactoryBot.create(:exercise, set_types: ["WeightWorkoutSet", "RepWorkoutSet"]) }
      let!(:weight_workout_set) { FactoryBot.create(:weight_workout_set, exercise: exercise) }
      let!(:rep_workout_set) { FactoryBot.create(:rep_workout_set, exercise: exercise) }

      it "retrieves weight workout sets" do
        expect(exercise.weight_workout_sets.count).to eq(1)
      end
    end
  end

  describe "highest weights (PRs)" do
    context "when exercise has associated weight workout sets" do
      let(:exercise) { FactoryBot.create(:exercise, set_types: ["WeightWorkoutSet", "RepWorkoutSet"]) }
      let(:highest_weight) {999}
      let!(:highest_weight_set) { FactoryBot.create(:weight_workout_set, exercise: exercise, rep_count: 1, rep_value: highest_weight) }
      let(:highest_reps) {999}
      let!(:est_highest_weight_set) { FactoryBot.create(:weight_workout_set, exercise: exercise, rep_count: highest_reps) }
      let!(:medium_weight_set) { FactoryBot.create(:weight_workout_set, exercise: exercise) }

      it "tracks highest_weight" do
        expect(exercise.highest_weight).to eq(highest_weight)
      end
      it "tracks estimated_highest_set" do
        expect(exercise.estimated_highest_set.id).to eq(est_highest_weight_set.id)
      end
      it "tracks highest_estimated_weight" do
        expect(exercise.highest_estimated_weight).to eq(est_highest_weight_set.estimated_max)
      end
    end
  end
end
