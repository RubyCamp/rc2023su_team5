require 'dxruby'
require_relative '../lib/ev3'

class Carrier
  COLOR_SENSOR = "3"
  LEFT_MOTOR = "C"
  RIGHT_MOTOR = "B"
  ARM_MOTOR = "B"
  CLAW_MOTOR = "C"
  DISTANCE_SENSOR = "4"
  PORT = "COM5"
  WHEEL_SPEED = 50
  MOTOR_SPEED1 = 5
  MOTOR_SPEED2 = 10
  ARM_SPEED = 10
  DEGRESS_OPEN_CLAW = 4500
  DEGRESS_CLOSE_CLAW = DEGRESS_OPEN_CLAW + 500
  CLAW_POWER = 30

  attr_reader :distance

  def initialize
    @brick = EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
    @brick.connect
    @busy = false
    @grabbing = false
  end

  # 色の取得
  def color 
    cnt = 0
    while cnt < 5
    puts @brick.get_sensor(COLOR_SENSOR, 2)
    cnt += 1
    end
  end

  # 前進する
  def run_forward(speed=WHEEL_SPEED)
    operate do
      @brick.reverse_polarity(*wheel_motors)
      @brick.start(speed, *wheel_motors)
    end
  end

  # 1マス前進する
  def advance(speed=MOTOR_SPEED1)
    operate do
      @brick.start(speed, *wheel_motors)
      sleep 5.8
      @brick.stop(true, *wheel_motors)

      cnt = 0
      while cnt < 5
      puts @brick.get_sensor(COLOR_SENSOR, 2)
      cnt += 1
      end
    end
  end

  # 右に向く
  def turnRight(speed=MOTOR_SPEED2)
    operate do
      @brick.start(speed, *wheel_motors)
      sleep 0.7
      @brick.stop(true, *wheel_motors)

      n = 0
      while n <= 33 do
      puts @brick.start(speed, RIGHT_MOTOR)
      sleep 0.2
      @brick.stop(true, *wheel_motors)
      n += 1
      end

      cnt = 0
      while cnt < 5
      puts @brick.get_sensor(COLOR_SENSOR, 2)
      cnt += 1
      end
    end
  end

  # 左に向く
  def turnLeft(speed=MOTOR_SPEED2)
    operate do
      @brick.start(speed, *wheel_motors)
      sleep 0.8
      @brick.stop(true, *wheel_motors)

      n = 0
      while n <= 34 do
      puts @brick.start(speed, LEFT_MOTOR)
      sleep 0.2
      @brick.stop(true, *wheel_motors)
      n += 1
      end
      cnt = 0
      while cnt < 5
      puts @brick.get_sensor(COLOR_SENSOR, 2)
      cnt += 1
      end
    end
  end


  # バックする
  def run_backward(speed=WHEEL_SPEED)
    operate do
      @brick.start(speed, *wheel_motors)
    end
  end

  # 右に回る
  def turn_right(speed=WHEEL_SPEED)
    operate do
      @brick.reverse_polarity(RIGHT_MOTOR)
      @brick.start(speed, *wheel_motors)
    end
  end

  # 左に回る
  def turn_left(speed=WHEEL_SPEED)
    operate do
      @brick.reverse_polarity(LEFT_MOTOR)
      @brick.start(speed, *wheel_motors)
    end
  end

  # アームを上げる
  def raise_arm(speed=ARM_SPEED)
    operate do
      @brick.reverse_polarity(ARM_MOTOR)
      @brick.start(speed, ARM_MOTOR)
    end
  end

  # アームを下げる
  def down_arm(speed=ARM_SPEED)
    operate do
      @brick.start(speed, ARM_MOTOR)
    end
  end

  # 物を掴む
  def grab
    return if @grabbing
    operate do
      @brick.reverse_polarity(CLAW_MOTOR)
      @brick.step_velocity(CLAW_POWER, DEGRESS_CLOSE_CLAW, 0, CLAW_MOTOR)
      @brick.motor_ready(CLAW_MOTOR)
      @grabbing = true
    end
  end

  # 物を離す
  def release
    return unless @grabbing
    operate do
      @brick.step_velocity(CLAW_POWER, DEGRESS_CLOSE_CLAW, 0, CLAW_MOTOR)
      @brick.motor_ready(CLAW_MOTOR)
      @grabbing = false
    end
  end

  # 動きを止める
  def stop
    @brick.stop(true, *all_motors)
    @brick.run_forward(*all_motors)
    @brick.reset(*all_motors)
    @busy = false
  end

  # ある動作中は別の動作はうけつけないようにする
  def operate
    unless @busy
      @busy = true
      yield(@brick)
      @busy = false
    end
  end

  # センサー情報の更新
  def update
    @distance = @brick.get_sensor(DISTANCE_SENSOR, 0)
  end

  def run
    update
    run_forward if Input.keyDown?(K_UP)
    run_backward if Input.keyDown?(K_DOWN)
    turn_left if Input.keyDown?(K_LEFT)
    turn_right if Input.keyDown?(K_RIGHT)
    raise_arm if Input.keyDown?(K_W)
    down_arm if Input.keyDown?(K_S)
    grab if Input.keyDown?(K_A)
    release if Input.keyDown?(K_D)
    stop if [K_UP, K_DOWN, K_LEFT, K_RIGHT, K_W, K_S].all?{|key| !Input.keyDown?(key) }
  end

  # 終了処理
  def close
    stop
    @brick.disconnect
  end

  def all_motors
    @all_motors ||= self.class.constants.grep(/MOTOR\z/).map{|c| self.class.const_get(c) }
  end

  def wheel_motors
    [LEFT_MOTOR, RIGHT_MOTOR]
  end

  def busy?
    return @busy
  end
end

carrier = Carrier.new()

# スタート（1マス直進する）
carrier.color

carrier.advance

moveN = 0
while moveN < 2 do
  if !carrier.busy?
    carrier.turnRight
    moveN += 1
  end
end

moveN = 0
while moveN < 2 do
  if !carrier.busy?
    carrier.advance
    moveN += 1
  end
end

moveN = 0
while moveN < 2 do
  if !carrier.busy?
    carrier.turnLeft
    moveN += 1
  end
end

moveN = 0
while moveN < 3 do
  if !carrier.busy?
    carrier.advance
    moveN += 1
  end
end

# begin
#   puts "starting..."
#   font = Font.new(32)
#   carrier = Carrier.new
#   puts "connected..."

#   Window.loop do
#     break if Input.keyDown?(K_SPACE)
#     carrier.run
#     Window.draw_font(100, 200, "#{carrier.distance.to_i}cm", font)
#   end
# rescue
#   p $!
#   $!.backtrace.each{|trace| puts trace}
# 終了処理は必ず実行する
# ensure
#   puts "closing..."
#   carrier.close
#   puts "finished..."
# end
