class Player
    def initialize()
        @x = 180
        @y = 120
        @degree = 0
        @img = Image.load("images/test.png") #向きの変更をチェックするために入れた画像である。画像は別途用意するものとする。
    end

    def go_forward # 前進する
        case @degree
        when 0 #画面上で下を向いている時
            @y += 60
        when 90 #画面上で右を向いている時
            @x += 60
        when 180 #画面上で上を向いている時
            @y -= 60
        when 270 #画面上で左を向いている時
            @x -= 60
        end
    end
    
    def back_forward # 後退する
        case @degree
        when 0
            @y -= 60
        when 90
            @x -= 60
        when 180
            @y += 60
        when 270
            @x += 60
        end
    end
    
    def turn_right # 右に45度回転する
        @degree -= 90
        @degree += 360 if @degree < 0 
    end

    def turn_left # 左に45度回転する
        @degree += 90
        @degree -= 360 if @degree >360
    end

    def draw # 画像の描画と回転を司る
        Window.draw_rot(@x, @y, @img, @degree * -1) #回転の角度が左右逆になっていたので-1をかけて調整している
    end
    
end