module ExerciseHelper

  def display_icon(exercise)
    exercise.icon.present? ? exercise.icon : 'bi-person-arms-up'
  end

end
