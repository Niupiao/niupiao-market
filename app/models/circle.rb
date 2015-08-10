class Circle
  
  def new
      @center = Point.new
      @radius = 0
  end

  def initialize(p1,p2,p3)
    if p1.nil?
      @center = Point.new(0,0)
      @radius = 0
    elsif p2.nil?
      @center = p1
      @radius = 0
    elsif p3.nil?
      @center = p1.midpoint(p2)
      @radius = p1.distance(@center)
    else
      x = (p3.getX * p3.getX * (p1.getY - p2.getY) + (p1.getX * p1.getX + (p1.getY - p2.getY) * (p1.getY - p3.getY)) * (p2.getY - p3.getY) + (p2.getX * p2.getX * (-p1.getY + p3.getY))) / (2 * (p3.getX * (p1.getY - p2.getY) + p1.getX * (p2.getY - p3.getY) + p2.getX * (-p1.getY + p3.getY)))
        
		  y = (p2.getY+p3.getY) / 2 - (p3.getX - p2.getX) / (p3.getY-p2.getY) * (x - (p2.getX + p3.getX) * 0.5)
			@center = Point.new(x, y)
			@radius = @center.distance(p1)
		end
  end
  
  def getCenter
    @center
  end
  
  def setCenter(point)
    @center = point
  end
  
  def getRadius
    @radius
  end
  
  def setRadius(i)
    @radius = i
  end
  
  def translate(point)
    @center.translate(point.getX, point.getY)
  end
  
  def offset(dr)
    @radius += dr
  end
  
  def scale(factor)
    @radius *= factor
  end
  
  def getDiameter
    @radius * 2
  end
  
  def getCircumference
    @radius * 2 * Math.PI
  end
  
  def getArea
    @radius **2 * Math.PI
  end
  
  def contains?(point)
    distance = @center.distance(point)
    if distance > @radius
      return 1
    elsif distance == @radius
      return 0
    else
      return -1
    end
  end
  
  def equals?(circle)
    @center.equals?(circle.getCenter) && @radius == circle.getRadius
  end

end