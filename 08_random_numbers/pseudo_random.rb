# A sampling of random number generators from Chapter 8.

require 'ruby-processing'

class PseudoRandom < Processing::App
  load_ruby_library 'control_panel'

  def setup
    control_panel do |c|
      c.menu(:method, 'linear_congruential', 'logistic', 'ruby_rand') { reset }
      c.slider(:multiplier) { reset }
      c.slider(:constant)   { reset }
      c.slider(:modulo)     { reset }      
      c.button :reset    
    end
            
    @scale = width / 100
    @multiplier = 19
    @constant = 51
    @modulo = 100
    @num = 25
    @method = 'linear_congruential'
    @repetitions = 100
    reset
    smooth
    no_stroke
    fill 50, 50, 200, 100
  end
  
  def draw
    background 200
    shrink = @nums.max.to_f / (height.to_f * 2)
    @nums.each_with_index do |count, x|
      oval x * @scale, height, @scale, count / shrink
    end
    generate_random_numbers
  end
  
  def generate_random_numbers
    100.times do 
      num = self.send(@method)
      @nums[num] += 1
    end
  end
  
  def reset
    @nums = (0..width).map { 0 }
  end
  
  #----------------------------------
  # Formulas:
  #----------------------------------
  
  # x(n+1) = (mult * x(n) + const) % mod
  def linear_congruential
    @num = (@multiplier.to_i * @num + @constant.to_i) % @modulo.to_i
  end
  
  # x(n+1) = mult * x(n) * (1 - x(n))
  # We need to scale this to go between 0..100
  def logistic
    mult = @multiplier / 232.0 + 3.57
    num = @num / 100.0
    @num = (mult * num * (1.0 - num)) * 100
  end
  
  # Use the build in random-number generator
  def ruby_rand
    rand * 100
  end
  
end

PseudoRandom.new :title => "Pseudo Random", :width => 500, :height => 250