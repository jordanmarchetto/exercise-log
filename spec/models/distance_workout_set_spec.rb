# spec/models/distance_workout_set_spec.rb
require 'rails_helper'

RSpec.describe DistanceWorkoutSet, type: :model do
  it "is valid with valid attributes" do
    distance_workout_set = FactoryBot.build(:distance_workout_set)
    expect(distance_workout_set).to be_valid
  end

  it "inherits attributes from WorkoutSet" do
    distance_workout_set = FactoryBot.build(:distance_workout_set)
    expect(distance_workout_set).to be_a(WorkoutSet)
  end

  it "has distance" do
    distance_workout_set = FactoryBot.build(:distance_workout_set)
    expect(distance_workout_set.class.has_distance?).to be_truthy
  end

  it "has duration" do
    distance_workout_set = FactoryBot.build(:distance_workout_set)
    expect(distance_workout_set.class.has_duration?).to be_truthy
  end

  it "has a name" do
    distance_workout_set = FactoryBot.build(:distance_workout_set)
    expect(distance_workout_set.class.name).not_to be_nil
  end

  it "has a description" do
    distance_workout_set = FactoryBot.build(:distance_workout_set)
    expect(distance_workout_set.class.name).not_to be_nil
  end
end
