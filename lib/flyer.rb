class Flyer

  attr_reader :score, :player, :x, :y, :config, :display_name, :colour

  def initialize(config)
    @config = config.is_a?(Config) ? config : Config.new(config)
    @player = @config.player || false
    @display_name = @config.display_name || 'Player'
    @colour = @config.colour || 0xff_ffffff
    @image = @config.image || $game.player_image
    @beep = Gosu::Sample.new("media/beep.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @star_index = 0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu.offset_x(@angle, 0.5)
    @vel_y += Gosu.offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle, 0.5, 0.5, 1, 1, colour)
  end

  def collect_stars
    if Gosu.distance(@x, @y, current_star.x, current_star.y) < 35
      @score += 1
      @star_index += 1
      mark_star
      true
    else
      false
    end
  end

  def mark_star
    if @player
      prev_star.set_inactive
      current_star.set_active
      next_star.set_leading
    end
  end

  def prev_star
    $game.stars[(@star_index - 1) % $game.stars.length]
  end

  def current_star
    $game.stars[@star_index % $game.stars.length]
  end

  def next_star_but_one
    $game.stars[(@star_index + 2) % $game.stars.length]
  end

  def next_star
    $game.stars[(@star_index + 1) % $game.stars.length]
  end


  def won?
    @score >= $game.config.target
  end

end
