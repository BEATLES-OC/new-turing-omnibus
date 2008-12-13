# Page 3's algorithm.
# Was broken for a long time making checkerboards because 
# I always forget how much Ruby rounds your int math. Fuck.

# Try a lowish "side" number, say, 18, and move the window
# for some low-budget psychedelia.

require 'ruby-processing'

class Wallpaper1 < Processing::App
  load_ruby_library "control_panel"

  def setup
    color_mode RGB, 1.0
    background 0.0
    fill 1.0
    stroke 1.0
    
    @corna = 10.0
    @cornb = 10.0
    @side = 20.0
    
    control_panel do |c|
      c.slider :corna, 0..100
      c.slider :cornb, 0..100
      c.slider :side,  0..1000
    end
    
    @i = 0
  end
  
  def draw
    return if @i > 300
    @i += 1
    width.times do |j|
      x = (@corna + @i.to_f) * @side / 300.0
      y = (@cornb + j.to_f) * @side / 300.0
      c = ((x*x) + (y*y)).to_i
      point(j, @i) if c % 2 == 0
    end
  end
  
  def mouse_pressed
    background 0.0
    @i = 0
  end
  
end

Wallpaper1.new :title => "Wallpaper 1", :width => 300, :height => 300