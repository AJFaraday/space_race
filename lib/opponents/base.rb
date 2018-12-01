module Opponents
  class Base < Flyer

    def target_angle
      Gosu.angle(x, y, current_star.x, current_star.y)
    end

    def diff_angle
      Gosu.angle_diff(@angle, target_angle)
    end

  end
end