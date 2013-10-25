module ApplicationHelper
  def fix_url(string)
    string.starts_with?("http://") ? string : "http://#{string}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end
    dt.strftime("on %m/%d/%Y | %I:%M%p %Z")
  end
end
