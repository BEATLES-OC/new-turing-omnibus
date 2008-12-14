# Let's draw the sucker.

require 'ruby-processing'

class Mandelbrot < Processing::App
  load_ruby_library "control_panel"
  
  def setup
    control_panel do |c|
      c.button :full_reset
      c.slider(:max_iter, 1..100) { reset }
      c.slider(:chunks, 1..100)   { reset }
    end
    
    @cols, @lines = width, height
    @max_iter = 20
    @chunks = 1
    @zoom_factor = 0.45
    
    full_reset
  end
  
  def reset
    background 255
    @im = @minim
    @y = 0
    @factor = 255 / @max_iter
  end
  
  def full_reset
    @minre, @minim  = -2.0, -1.0
    @maxre, @maxim  =  1.0,  1.0
    reset
  end
  
  def mouse_pressed
    x, y = -((width/2.0-mouse_x)/width.to_f), -((height/2.0-mouse_y)/height.to_f)
    range_im, range_re = @maxim - @minim, @maxre - @minre
    q_im, q_re = range_im * @zoom_factor, range_re * @zoom_factor
    shift_im, shift_re = range_im * y, range_re * x
    @minim = @minim + shift_im + q_im
    @maxim = @maxim + shift_im - q_im
    @minre = @minre + shift_re + q_re
    @maxre = @maxre + shift_re - q_re
    reset
  end
  
  
  def draw
    @chunks.to_i.times do
    
      y = (@y += 1)
      return if y > height
      
      @re = @minre
      @cols.times do |x|
        zr, zi = @re, @im
        n = 0
        @max_iter.to_i.times do |n|
          a, b = zr*zr, zi*zi
          break if a+b > 4.0
          zr, zi = a-b+@re, 2*zr*zi+@im
          n += 1
        end
        stroke(n * @factor)
        point(x, y)
        @re += (@maxre-@minre)/@cols
      end
      @im += (@maxim-@minim)/@lines
      
    end
  end
  
end

Mandelbrot.new :width => 400, :height => 400