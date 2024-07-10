# spec/views/exercises/edit.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "exercises/edit.html.erb", type: :view do
  it "renders the edit exercise form" do
    exercise = FactoryBot.create(:exercise)
    assign(:exercise, exercise)
    render
    expect(rendered).to have_selector("form[action='#{exercise_path(exercise)}'][method='post']")
  end
end
