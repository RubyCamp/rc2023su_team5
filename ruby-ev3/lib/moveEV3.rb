require_relative 'ev3'
require_relative '../examples/carrier'

# COLOR_SENSOR = "3"
# LEFT_MOTOR = "C"
# RIGHT_MOTOR = "B"
# PORT = "COM5"
# MOTOR_SPEED1 = 5
# MOTOR_SPEED2 = 10

puts "starting..."
brick = EV3::Brick.new(EV3::Connections::Bluetooth.new(PORT))
brick.connect
carrier = Carrier.new()

puts "connected..."
motors = [LEFT_MOTOR, RIGHT_MOTOR]
brick.reset(*motors)   # モーターの回転方向を初期化

# 3マス直進
carrier.advance

# # 右に90度回転後、1マス直進する
brick.start(MOTOR_SPEED1, *motors)
sleep 0.7
brick.stop(true, *motors)
cnt = 0
while cnt < 5
  puts brick.get_sensor(COLOR_SENSOR, 2)
  cnt += 1
end
n = 0
while n <= 36 do
    puts brick.start(MOTOR_SPEED2, RIGHT_MOTOR)
    sleep 0.2
    brick.stop(true, *motors)
    n = n + 1
end
brick.reset(*motors) 

# # 右に90度回転後、3マス直進
# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

# # 左に90度回転後、1マス直進
# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

# # 左に90度回転後、3マス直進
# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

# brick.start(MOTOR_SPEED, *motors)
# sleep 0.2
# brick.stop(true, *motors)

puts "closing..."
brick.stop(true, *motors)
brick.clear_all
brick.disconnect
puts "finished..."
