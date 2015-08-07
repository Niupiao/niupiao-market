module ApplicationHelper
    
  #Returns full title on per-page basis
  def full_title(page_title = '')
    base_title = "#Dev"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def item_exists?(item_id)
    !Item.find_by(id: item_id).nil?
  end
  
  def user_exists?(user_id)
    !User.find_by?(id: user_id).nil?
  end
  
  # Rendering a readable string that displays the difference between two times.
  def time_diff(start_time, end_time)
    seconds_diff = (start_time - end_time).to_i.abs
  
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
  
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
  
    seconds = seconds_diff
  
    "#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}:#{seconds.to_s.rjust(2, '0')}"
  end

end
