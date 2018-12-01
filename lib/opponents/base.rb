module Opponents
  class Base < Flyer

    def initialize(config)
      super
      @n = 0
      @speed = config.speed || 40
      @interval = 100.0 / @speed
      @x = ($game.width / 100.0) * config.x if config.x
      @y = ($game.height / 100.0) * config.y if config.y
    end

    def move_forward
      accelerate if @n.to_i == 0
      @n += 1
      @n %= @interval
    end

    def target_angle
      Gosu.angle(x, y, current_star.x, current_star.y)
    end

    def diff_angle
      Gosu.angle_diff(@angle, target_angle)
    end

  end
end