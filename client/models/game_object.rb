class GameObject
  attr :parent_id
  attr :x
  attr :y
  attr :image
  
  def initialize(data)
    @x = data[:x] || data["x"]
    @y = data[:y] || data["y"]
    @angle = (data[:angle] || data["angle"]).radians_to_gosu
    @parent_id = data[:parent_id] || data[:player_id] || data["parent_id"] || data["player_id"]
    @id = data[:id] || data["id"]
    @image = data[:image] || data["image"]
    @health = data[:health] || data["health"]
  end
  
  def self.load_assets(window)
    @@assets = {:ship => Gosu::Image.new(window, "images/ship.png", false),
                :missile => Gosu::Image.new(window, "images/missile.png", false)}
                
    @@health_font = Gosu::Font.new(window, "Myriad Pro", 20)
  end
  
  def offsets
    width, height = GameWindow.window_size
    [@x - (width / 2), @y - (height / 2)]
  end
  
  def draw(offset_x, offset_y)
    x = @x - offset_x
    y = @y - offset_y
    @@assets[@image.to_sym].draw_rot(x, y, 1, @angle)
  end
  
  def draw_health
    if @health
      @@health_font.draw("HEALTH #{@health}", 20, 20, 100)
    end
  end
end