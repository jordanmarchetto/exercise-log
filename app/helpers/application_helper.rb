module ApplicationHelper

  def display_time(timestamp)
    timestamp.strftime("%I:%M %p")
  end

  def display_date(timestamp)
    timestamp.strftime("%m/%d/%Y")
  end
end
