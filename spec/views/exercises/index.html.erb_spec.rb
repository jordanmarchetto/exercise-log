# spec/views/exercises/index.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "exercises/index.html.erb", type: :view do
  it "displays all exercises" do
    assign(:exercises, [
      FactoryBot.create(:exercise, name: "Push Up"),
      FactoryBot.create(:exercise, name: "Squat")
    ])
    render
    expect(rendered).to match /Push Up/
    expect(rendered).to match /Squat/
  end
end
