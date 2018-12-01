module Opponents
  class Turner < Base

    def move
      if diff_angle > 3
        turn_right
      elsif diff_angle < -3
        turn_left
      else
        move_forward
      end
      super
    end

  end
end