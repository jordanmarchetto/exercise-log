# spec/models/workout_set_spec.rb
require 'rails_helper'

RSpec.describe WorkoutSet, type: :model do
  it "is valid with valid attributes" do
    workout_set = FactoryBot.build(:workout_set)
    expect(workout_set).to be_valid
  end

  it "is not valid without an exercise" do
    workout_set = FactoryBot.build(:workout_set, exercise: nil)
    expect(workout_set).to_not be_valid
  end

  describe "data" do
    let(:exercise) { FactoryBot.create(:exercise) }
    let!(:workout_set) { FactoryBot.create(:workout_set, exercise: exercise, data: {is_pr: }) }

    context "when is_pr is true" do
      let(:is_pr) {true}
      it "is_pr? returns true" do
        expect(workout_set.is_pr?).to eq(true)
      end
    end

    context "when is_pr is true" do
      let(:is_pr) {false}
      it "is_pr? returns false" do
        expect(workout_set.is_pr?).to eq(false)
      end
    end
  end
end
