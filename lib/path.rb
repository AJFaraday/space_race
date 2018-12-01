class Path

  def self.load
    $game.config.path.each do |point|
      draw_star(point.x, point.y)
    end
  end

  private

  def self.draw_star(x, y)
    x = ($game.width / 100.0) * x
    y = ($game.height / 100.0) * y
    $game.stars.push(Star.new(x, y))
  end

end