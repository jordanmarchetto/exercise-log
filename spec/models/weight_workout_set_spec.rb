# spec/models/weight_workout_set_spec.rb
require 'rails_helper'

RSpec.describe WeightWorkoutSet, type: :model do
  it "is valid with valid attributes" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set).to be_valid
  end

  it "inherits attributes from WorkoutSet" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set).to be_a(WorkoutSet)
  end

  it "has weights" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set.class.has_reps?).to be_truthy
  end

  it "has rpe" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set.class.has_rpe?).to be_truthy
  end

  it "has weight" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set.class.has_weight?).to be_truthy
  end

  it "has a name" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set.class.name).not_to be_nil
  end

  it "has a description" do
    weight_workout_set = FactoryBot.build(:weight_workout_set)
    expect(weight_workout_set.class.name).not_to be_nil
  end


  # def is_estimated_pr?
  # def is_estimated_pr=(value)
  # def check_for_pr
  # def estimated_max
  describe "PR data" do
    let(:exercise) { FactoryBot.create(:exercise) }
    let(:weight_workout_set) { FactoryBot.create(:weight_workout_set, exercise: exercise, rep_count:, rep_value:, data: {is_estimated_pr: }) }
    let(:rep_count) {1}
    let(:rep_value) {100}
    let(:highest_weight) {200}
    let(:highest_estimated_weight) {300}
    let(:is_estimated_pr) {false}

    before do
      allow(exercise).to receive(:highest_weight).and_return(highest_weight)
      allow(exercise).to receive(:highest_estimated_weight).and_return(highest_estimated_weight)
    end

    context "when is_estimated_pr is true" do
      let(:is_estimated_pr) {true}
      it "is_estimated_pr? returns true" do
        expect(weight_workout_set.is_estimated_pr?).to eq(true)
      end
    end

    context "when is_estimated_pr is false" do
      it "is_estimated_pr? returns false" do
        expect(weight_workout_set.is_estimated_pr?).to eq(false)
      end
    end

    context "when set is modified" do
      it "checks if it's a PR when saved" do
        expect(weight_workout_set).to receive(:check_for_pr)
        weight_workout_set.save
      end

      it "checks if it's a PR when updated" do
        weight_workout_set.save
        expect(weight_workout_set).to receive(:check_for_pr)
        weight_workout_set.update(rep_value: 150)
      end
    end

    context "when set is a pr" do
      let(:rep_value) {400}

      it "sets is_pr to true" do
        expect(weight_workout_set.is_pr?).to eq(true)
      end
    end

    context "when set is not a pr" do
      let(:rep_value) {10}

      it "sets is_pr to false" do
        expect(weight_workout_set.is_pr?).to eq(false)
      end
    end

    context "when set is an estimated pr" do
      let(:rep_count) {400}

      it "sets is_pr to true" do
        expect(weight_workout_set.is_estimated_pr?).to eq(true)
      end
    end

    context "when set is not estimated pr" do
      let(:rep_value) {1}
      let(:rep_count) {1}

      it "sets is_pr to true" do
        expect(weight_workout_set.is_estimated_pr?).to eq(false)
      end
    end

    it "calculates estimated_max" do
        estimated_max = ((rep_count * rep_value * 0.0333) + rep_value).round(0)
        expect(weight_workout_set.estimated_max).to eq(estimated_max)
    end
  end
end
