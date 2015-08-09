class Point
    
  def new
    @x ||= 0
    @y ||= 0
  end
  
  def initialize(x, y)
    @x = x
    @y = y
  end
  
  def new(p)
    @x = p.getX
    @y = p.getY
  end
  
  def getX
    return @x
  end
  
  def getY
    return @y
  end
  
  def setX(i)
    @x = i
  end
  
  def setY(i)
    @y = i
  end
  
  def translate(p)
    setX(p.getX)
    setY(p.getY)
  end
  
  def translate(x, y)
    setX(x)
    setY(y)
  end
  
  def offset(dx, dy)
    setX(@x + dx)
    setY(@y + dy)
  end
    
  def distance(p)
    dx = @x - p.getX
    dy = @y - p.getY
    Math.sqrt(dx ** 2 + dy ** 2)
  end
  
  def distance2(p)
    dx = @x - p.getX
    dy = @y - p.getY
    dx ** 2 + dy ** 2
  end
  
  def midpoint(p)
    Point.new((@x + p.getX) / 2, (@y + p.getY) / 2)
  end
  
  def equals?(p)
    @x == p.getX && @y == p.getY
  end
end