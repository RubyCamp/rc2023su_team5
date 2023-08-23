# main.rbとあるが最初の真っ白なmap上をキー入力で動くようにしているコードである
require 'dxruby'
require_relative 'player'

player = Player.new

font = Font.new(15)
wakus = []
wakus << Sprite.new(180, 120, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(240, 120, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(300, 120, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(360, 120, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(360, 180, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(300, 180, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(240, 180, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(180, 180, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(180, 240, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(240, 240, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(300, 240, Image.new(50, 50, C_WHITE))
wakus << Sprite.new(360, 240, Image.new(50, 50, C_WHITE))

Window.loop do 
    break if Input.key_push?(K_ESCAPE)

    player.go_forward if Input.key_push?(K_UP)
    player.back_forward if Input.key_push?(K_DOWN)
    player.turn_right if Input.key_push?(K_RIGHT) 
    player.turn_left if Input.key_push?(K_LEFT)

    Window.draw_font(183, 100, "START", font)

    wakus.each do |w|
        w.draw
    end

    player.draw

end