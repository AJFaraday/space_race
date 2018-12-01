module Opponents
  class Simple < Base

    def display_name
      'Simple'
    end

    def initialize(image, player = false)
      @n = 0
      super
    end

    def move
      if diff_angle > 0
        turn_right
      elsif diff_angle < 0
        turn_left
      end
      accelerate if @n == 0
      @n += 1
      @n %= 5
      super
    end

  end
end