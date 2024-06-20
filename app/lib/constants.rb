module Constants
  # application-wide constants here
  WEIGHT_UNIT = ENV['WEIGHT_UNIT'] || "lbs."
  DISTANCE_UNITS = ['mi', 'km'].freeze
  TIME_UNITS = ['ms', 's', 'min', 'hr'].freeze
end
