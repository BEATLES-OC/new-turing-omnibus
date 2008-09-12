class Wallpaper < Processing::App
  has_slider :corna
  has_slider :cornb
  has_slider :side
  
  def setup
    background black
    fill white
  end
  
  def mouse_pressed
    100.times do |i|
      100.times do |j|
        x = @corna + i * @side / 100
        y = @cornb + j * @side / 100
        c = (x**2 + y**2).to_i
        point(i, j) if (c % 2 == 0)
      end
    end
  end
  
end

Wallpaper.new :title => "Wallpaper 1"