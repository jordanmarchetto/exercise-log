module ApplicationHelper

  def display_time(timestamp)
    timestamp.strftime("%I:%M %p")
  end

  def display_date(timestamp)
    timestamp.strftime("%m/%d/%Y")
  end

  def display_date_long(timestamp)
    timestamp.strftime("%A, %B %e, %Y")
  end

  def javascript_constants
    "<script>window.Constants = #{constants_to_json.html_safe};</script>".html_safe
  end

  def lighten_color(hex_color, percentage)
    hex_color = hex_color.gsub('#', '')
    rgb = hex_color.scan(/../).map { |color| color.to_i(16) }
    new_rgb = rgb.map { |c| (c + (255 - c) * (percentage / 100.0)).round }
    "#%02x%02x%02x" % new_rgb
  end

  private

  def constants_to_json
    {
      weight_unit: Constants::WEIGHT_UNIT
    }.to_json
  end

end
