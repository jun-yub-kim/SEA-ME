from donkeycar.parts.controller import Joystick, JoystickController



class MyJoystick(Joystick):
    #An interface to a physical joystick available at /dev/input/js0
    def __init__(self, *args, **kwargs):
        super(MyJoystick, self).__init__(*args, **kwargs)

            
        self.button_names = {
            0x131 : 'B',
            0x130 : 'A',
            0x133 : 'X',
            0x134 : 'Y',
            0x138 : 'L2', #138 doesnt exist in original comde
            0x136 : 'L1',
            0x139 : 'R2', #139 doesnt exist in original comde
            0x137 : 'R1',
        }


        self.axis_names = {
            0x1 : 'left_y',
            0x0 : 'left_x',
            0x5 : 'right_y',
            0x2 : 'right_x',
        }



class MyJoystickController(JoystickController):
    #A Controller object that maps inputs to actions
    def __init__(self, *args, **kwargs):
        super(MyJoystickController, self).__init__(*args, **kwargs)

        


    def init_js(self):
        #attempt to init joystick
        try:
            self.js = MyJoystick(self.dev_fn)
            self.js.init()
        except FileNotFoundError:
            print(self.dev_fn, "not found.")
            self.js = None
        return self.js is not None


    def init_trigger_maps(self):
        #init set of mapping from buttons to function calls
            
        self.button_down_trigger_map = {
            'X' : self.emergency_stop,
            'A' : self.increase_max_throttle,
            'B' : self.decrease_max_throttle,
            'L1' : self.led_left,
            'R1' : self.led_right,
        }


        self.axis_trigger_map = {
            'left_y' : self.set_steering,
            'right_x' : self.set_throttle,
        }