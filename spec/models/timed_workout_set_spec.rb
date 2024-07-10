# spec/models/timed_workout_set_spec.rb
require 'rails_helper'

RSpec.describe TimedWorkoutSet, type: :model do
  it "is valid with valid attributes" do
    timed_workout_set = FactoryBot.build(:timed_workout_set)
    expect(timed_workout_set).to be_valid
  end

  it "inherits attributes from WorkoutSet" do
    timed_workout_set = FactoryBot.build(:timed_workout_set)
    expect(timed_workout_set).to be_a(WorkoutSet)
  end

  it "has duration" do
    timed_workout_set = FactoryBot.build(:timed_workout_set)
    expect(timed_workout_set.class.has_duration?).to be_truthy
  end

  it "has a name" do
    timed_workout_set = FactoryBot.build(:timed_workout_set)
    expect(timed_workout_set.class.name).not_to be_nil
  end

  it "has a description" do
    timed_workout_set = FactoryBot.build(:timed_workout_set)
    expect(timed_workout_set.class.name).not_to be_nil
  end
end
