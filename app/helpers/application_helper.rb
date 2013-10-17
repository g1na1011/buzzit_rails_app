module ApplicationHelper
  def fix_url(string)
    string.starts_with?("http://") ? string : "http://#{string}"
  end

  def display_datetime(dt)
    dt.strftime("on %m/%d/%Y | %I:%M%p")
  end
end
