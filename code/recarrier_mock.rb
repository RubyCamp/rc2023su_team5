  # 色の取得
  def color 
    cnt = 0
    menu = {"num_two": 0, "num_three": 0, "num_five": 0, "num_six": 0}
    while cnt < 5
        #puts @brick.get_sensor(COLOR_SENSOR, 2)

        color_num = @brick.get_sensor(COLOR_SENSOR, 2)

        #青
        if color_num == 2.0
            menu[:num_two] +=1
        #緑
        elsif color_num == 3.0
            menu[:num_three] += 1
        #赤
        elsif color_num == 5.0
            menu[:num_five] += 1
        #白
        elsif color_num == 6.0
            menu[:num_six] += 1
        end

        cnt += 1
    end

    #puts "----ans----"
    
    ans = menu.max{ |x, y| x[1] <=> y[1] }[0].to_s

    #puts ans

    if ans == 'num_two'
        2.0
    elsif ans == 'num_three'
        3.0
    elsif ans == 'num_five'
        5.0
    elsif ans == 'num_six'
        6.0
    end
  end