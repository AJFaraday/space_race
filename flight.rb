require_relative 'lib/environment.rb'

class Flight < Gosu::Window

  attr_accessor :player, :star_anim, :font, :stars, :config
  attr_accessor :active_colour, :leading_colour, :inactive_colour

  def initialize
    @config = Config.new
    super(@config.size.x, @config.size.y)
    self.caption = 'Flight'

    @background_image = Gosu::Image.new(
      "media/space.png",
      tileable: true
    )

    @active_colour = Gosu::Color.rgba(0, 0, 255, 255)
    @leading_colour = Gosu::Color.rgba(128, 0, 128, 255)
    @inactive_colour = Gosu::Color.rgba(255, 0, 0, 255)

    init_flyers

    @star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @stars = Array.new
    @font = Gosu::Font.new(20)
    @end_font = Gosu::Font.new(200)
    @active = true
  end

  def init_flyers
    @player_image = Gosu::Image.new("media/starfighter.bmp")
    @player = Flyer.new(@player_image, true)
    @player.warp(320, 240)
    @flyers = [@player]

    config.opponents.each do |opponent|
      opp = Opponents.const_get(opponent.kls).new(@player_image)
      opp.warp((width / 2), (height / 2))
      @flyers.push(opp)
    end
  end

  def show
    Path.load
    player.mark_star
    super
  end

  def update
    if @active
      if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
        @player.turn_left
      end
      if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
        @player.turn_right
      end
      if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
        @player.accelerate
      end
      @flyers.each(&:move)
    end

    if @flyers.any?(&:won?)
      @active = false
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @flyers.each(&:draw)
    @flyers.each(&:collect_stars)

    @stars.each(&:draw)
    draw_ui
  end

  def draw_ui
    @font.draw_text(
      "Score: #{@player.score}/#{config.target}",
      10, 30,
      ZOrder::UI,
      1.0,
      1.0,
      Gosu::Color::YELLOW
    )
    @font.draw_text(
      "Level 1",
      10, 10,
      ZOrder::UI,
      1.0,
      1.0,
      Gosu::Color::YELLOW
    )

    @flyers.select { |f| !f.player }.each do |opp|
      msg = "#{opp.display_name}: #{opp.score}/#{config.target}"
      @font.draw_text(
        msg,
        ($game.width - @font.text_width(msg) - 10),
        10,
        ZOrder::UI,
        1.0,
        1.0,
        Gosu::Color::YELLOW
      )
    end
    if !@active
      if @player.won?
        @end_font.draw_text('WIN', 150, 40, ZOrder::UI)
      else
        @end_font.draw_text('LOSE', 90, 40, ZOrder::UI)
      end
      @ended_at ||= Gosu.milliseconds
      count = 3 - (Gosu.milliseconds - @ended_at) / 1000
      @end_font.draw_text(count, 270, 200, ZOrder::UI)
      new_game if @count = 0
    end
  end

  def new_game
    if @player.won?
      # next level
    else
      # repeat level
    end
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

end

$game = Flight.new
$game.show
