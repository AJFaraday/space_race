module Opponents
  class Simple < Base

    attr_reader :speed

    def move
      if diff_angle > 0
        turn_right
      elsif diff_angle < 0
        turn_left
      end
      move_forward
      super
    end

  end
end