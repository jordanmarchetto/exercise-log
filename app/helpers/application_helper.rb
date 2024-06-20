module ApplicationHelper

  def display_time(timestamp)
    timestamp.strftime("%I:%M %p")
  end

  def display_date(timestamp)
    timestamp.strftime("%m/%d/%Y")
  end

  def javascript_constants
    "<script>window.Constants = #{constants_to_json.html_safe};</script>".html_safe
  end

  private

  def constants_to_json
    {
      weight_unit: Constants::WEIGHT_UNIT
    }.to_json
  end

end
