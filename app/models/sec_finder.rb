class SecFinder
  
  def new
  end
  
  def findSec(n, p, m, b)
    sec = Circle.new(nil,nil,nil)
    if m == 1
      sec = Circle.new(b[0],nil,nil)
    elsif m == 2
      sec = Circle.new(b[0],b[1],nil)
    elsif m == 3
      sec = Circle.new(b[0],b[1],b[2])
    end
    (0...n).each do |i|
      if sec.contains?(p[i]) == 1
        b[m] = Point.new(p[i].getX, p[i].getY)
        sec = findSec(i, p, m+1, b)
      end
    end
    
    sec
  end
  
end