module ItemsHelper
  
  
  # An internal search for use in views. Relies primarily on tags.
  def internal_search(tags_hash)
    search = []
    scores = []
    if tags_hash
      tags_keys = tags_hash.keys.map(&:downcase)
      tags_hash = Hash[tags_hash.map {|k, v| [k.downcase, v]}]
      target_score = tags_hash.values.max # Must contain at least the most
                                          # popular tag.
      Item.all.each do |item|
        search_space = item.tags.join(" ").downcase
        score = 0
        tags_keys.each do |tag|
          if(search_space.include? tag)
            score += (search_space.scan(/#{tag}/).length * tags_hash[tag])
          end
        end
        
        if(score >= target_score)
          search += [item]
          scores += [score]
        end
      end
      
      search.sort_by.with_index{|_,i| scores[i]}
      search.reverse!
      return search
    end
  end
end