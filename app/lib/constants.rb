module Constants
  # application-wide constants here
  WEIGHT_UNIT = ENV['WEIGHT_UNIT'] || "lbs."
  DISTANCE_UNITS = ['mi', 'km', 'm', ' miles'].freeze
  TIME_UNITS = ['s', 'min', 'hr', ' seconds', ' minutes', ' hours'].freeze
  MAX_PROGRESS_HISTORY = 180
end
