# Page 3's algorithm.
# Was broken for a long time because I always forget 
# that Ruby rounds your int math. Fuck.
# Still seems wrong. Something smells fishy.

require 'ruby-processing'

class Wallpaper1 < Processing::App
  has_slider :corna
  has_slider :cornb
  has_slider :side

  def setup
    color_mode RGB, 1.0
    background 0.0
    fill 1.0
    stroke 1.0
    
    @corna = 10.0
    @cornb = 10.0
    @side = 20.0
    
    @i = 0
  end
  
  def draw
    return if @i > 300
    @i += 1
    300.times do |j|
      x = (@corna + @i.to_f) * @side / 300.0
      y = (@corna + j.to_f) * @side / 300.0
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