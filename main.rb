# main.rbとあるが最初の真っ白なmap上をキー入力で動くようにしているコードである

require 'dxruby'
require_relative 'navigator'

navigator = Navigator.new

font = Font.new(15)

wakus = {
    :a =>  Sprite.new(180, 120, Image.new(50, 50, C_WHITE)),
    :b =>  Sprite.new(240, 120, Image.new(50, 50, C_WHITE)),
    :c =>  Sprite.new(300, 120, Image.new(50, 50, C_WHITE)),
    :d =>  Sprite.new(360, 120, Image.new(50, 50, C_WHITE)),
    :e =>  Sprite.new(360, 180, Image.new(50, 50, C_WHITE)),
    :f =>  Sprite.new(300, 180, Image.new(50, 50, C_WHITE)),
    :g =>  Sprite.new(240, 180, Image.new(50, 50, C_WHITE)),
    :h =>  Sprite.new(180, 180, Image.new(50, 50, C_WHITE)),
    :i =>  Sprite.new(180, 240, Image.new(50, 50, C_WHITE)),
    :j =>  Sprite.new(240, 240, Image.new(50, 50, C_WHITE)),
    :k =>  Sprite.new(300, 240, Image.new(50, 50, C_WHITE)),
    :l =>  Sprite.new(360, 240, Image.new(50, 50, C_WHITE)),
}

navigator_points = {
    :a =>  [0,0],
    :b =>  [1,0],
    :c =>  [2,0],
    :d =>  [3,0],
    :e =>  [3,1],
    :f =>  [2,1],
    :g =>  [1,1],
    :h =>  [0,1],
    :i =>  [0,2],
    :j =>  [1,2],
    :k =>  [2,2],
    :l =>  [3,2],
}

color_mapping = {
    1.0 => C_BLACK,
    2.0 => C_BLUE,
    3.0 => C_GREEN,
    5.0 => C_RED,
    6.0 => C_WHITE,
}

 # 
 # color = color_mapping[sensor_value]
 # wakus[:a].image = Image.new(50, 50, color)

Window.loop do 
    break if Input.key_push?(K_ESCAPE)

    navigator.go_forward if Input.key_push?(K_UP)
    navigator.back_forward if Input.key_push?(K_DOWN)
    navigator.turn_right if Input.key_push?(K_RIGHT) 
    navigator.turn_left if Input.key_push?(K_LEFT)

    Window.draw_font(183, 100, "START", font)
    
    wakus.each do |key, sprite|
        sprite.draw
    end
    
    navigator.draw

end