# spec/models/rep_workout_set_spec.rb
require 'rails_helper'

RSpec.describe RepWorkoutSet, type: :model do
  it "is valid with valid attributes" do
    rep_workout_set = FactoryBot.build(:rep_workout_set)
    expect(rep_workout_set).to be_valid
  end

  it "inherits attributes from WorkoutSet" do
    rep_workout_set = FactoryBot.build(:rep_workout_set)
    expect(rep_workout_set).to be_a(WorkoutSet)
  end

  it "has reps" do
    rep_workout_set = FactoryBot.build(:rep_workout_set)
    expect(rep_workout_set.class.has_reps?).to be_truthy
  end

  it "has rpe" do
    rep_workout_set = FactoryBot.build(:rep_workout_set)
    expect(rep_workout_set.class.has_rpe?).to be_truthy
  end

  it "has a name" do
    rep_workout_set = FactoryBot.build(:rep_workout_set)
    expect(rep_workout_set.class.name).not_to be_nil
  end

  it "has a description" do
    rep_workout_set = FactoryBot.build(:rep_workout_set)
    expect(rep_workout_set.class.name).not_to be_nil
  end
end
