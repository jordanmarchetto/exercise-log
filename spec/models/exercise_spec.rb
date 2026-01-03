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

  describe "all-time vs scoped weight sets" do
    context "when there are sets both inside and outside the default scope" do
      let(:exercise) { FactoryBot.create(:exercise, set_types: ["WeightWorkoutSet"]) }
      let!(:recent_set)  { FactoryBot.create(:weight_workout_set, exercise: exercise, rep_value: 100, rep_count: 5, created_at: 1.day.ago) }
      let!(:old_set)     { FactoryBot.create(:weight_workout_set, exercise: exercise, rep_value: 200, rep_count: 5, created_at: 7.months.ago) }

      it "excludes old sets from `weight_workout_sets`" do
        expect(exercise.weight_workout_sets).to include(recent_set)
        expect(exercise.weight_workout_sets).not_to include(old_set)
      end

      it "includes old sets in `all_time_weight_workout_sets`" do
        expect(exercise.all_time_weight_workout_sets).to include(recent_set, old_set)
      end

      it "`highest_weight` respects the scope" do
        expect(exercise.highest_weight).to eq(100)
        expect(exercise.highest_weight(all_records: true)).to eq(200)
      end

      it "`highest_weight_set` respects the scope" do
        expect(exercise.highest_weight_set).to eq(recent_set)
        expect(exercise.highest_weight_set(all_records: true)).to eq(old_set)
      end

      it "`estimated_highest_set` respects the provided scope" do
        # with our rep_count/rep_value values, old_set has a larger estimated_max
        expect(recent_set.estimated_max).to be < old_set.estimated_max
        expect(exercise.estimated_highest_set).to eq(recent_set)
        expect(exercise.estimated_highest_set(all_records: true)).to eq(old_set)
      end

      it "`estimated_highest_set_ever` and `highest_estimated_weight_ever` return all-time best" do
        expect(exercise.estimated_highest_set_ever.id).to eq(old_set.id)
        expect(exercise.highest_estimated_weight_ever).to eq(old_set.estimated_max)
      end
    end

    context "when there are no weight sets" do
      let(:exercise) { FactoryBot.create(:exercise) }

      it "returns sensible defaults for highest/estimated methods" do
        expect(exercise.highest_weight).to eq(0)
        expect(exercise.highest_weight_set).to be_nil
        expect(exercise.estimated_highest_set).to be_nil
        expect(exercise.highest_estimated_weight).to be_nil
      end
    end
  end
end
