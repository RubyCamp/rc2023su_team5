# DXruby上にmapを表示するコード

require 'dxruby'
require_relative 'navigator'
require_relative 'carrier'

navigator = Navigator.new
carrier = Carrier.new
carrier.search_map

font = Font.new(15)
navigator_route = [:b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l]

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

 # mapの画像を変更する処理
navigator_route.each.with_index do |node_name, i|
    # 1. マスの色をcarrier.node_colors[i]から取得
    sensor_color = carrier.node_colors[i]
    # 2. 1.の情報をcolor_mappingでカラー定数に変換
    color = color_mapping[sensor_color]
    # 3. wakusのnode_nameのSpriteを2.のカラー定数のImageで更新(Sprite#image=で更新)
    wakus[node_name].image = Image.new(50, 50, color)
end

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