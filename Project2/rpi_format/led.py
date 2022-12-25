from gpiozero import LED
from time import sleep

## add this to controller.py 1054

def led_left():
    led = LED(26)
    count = 0
    while True:
        led.on()
        sleep(0.3)
        led.off()
        sleep(0.3)
        count = count + 1
        if count >= 10:
            break


def led_right():
    led = LED(17)
    count = 0
    while True:
        led.on()
        sleep(0.3)
        led.off()
        sleep(0.3)
        count = count + 1
        if count >= 10:
            break

led_left()