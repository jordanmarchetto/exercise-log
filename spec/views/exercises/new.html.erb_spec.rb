# spec/views/exercises/new.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "exercises/new.html.erb", type: :view do
  it "renders the new exercise form" do
    assign(:exercise, Exercise.new)
    render
    expect(rendered).to have_selector("form[action='#{exercises_path}'][method='post']")
  end
end
