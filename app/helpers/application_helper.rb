module ApplicationHelper
    
  #returns full title on per-page basis
  def full_title(page_title = '')
    base_title = "#Dev"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def item_exists?(item_id)
    item = Item.find_by(id: item_id)
    !!item
  end
  
  def user_exists?(user_id)
    !!User.find_by?(id: user_id)
  end
end
