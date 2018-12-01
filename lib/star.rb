class Star
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @animation = $game.star_anim
    set_inactive
  end

  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    img.draw(
      @x - img.width / 2.0,
      @y - img.height / 2.0,
      ZOrder::STARS,
      1,
      1,
      @color,
      :add
    )
  end

  def set_active
    @color = $game.active_colour
  end

  def set_leading
    @color = $game.leading_colour
  end

  def set_inactive
    @color = $game.inactive_colour
  end

end
