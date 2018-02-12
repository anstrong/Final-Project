from vpython import *
import random

i = 0

balls = []

class Ball(sphere):
    def __init__(self):
        x_high = random.randint(4,10)
        x_low = random.randint(-10,-4)
        y_high = random.randint(4,10)
        y_low = random.randint(-10,-4)

        if random.randint(0,1) == 0:
            x = x_low
        else:
            x = x_high

        if random.randint(0,1) == 0:
            y = y_low
        else:
            y = y_high

        sphere.__init__(self, pos = vector(x,y,10), radius = .5)

        self.rx = random.uniform(-1, 1)
        self.ry = random.uniform(-1, 1)
        self.rz = 1

        self.dx = 1
        self.dy = 1
        self.dz = 1

        self.trapped = False

    def collision_check(self):
        x_in = -2.5 <= self.pos.x <= 2.5
        y_in = -2.5 <= self.pos.y <= 2.5
        z_in = -7.5 <= self.pos.z <= -2.5

        if x_in and y_in and z_in:
            if self.trapped == True:
                self.rx = 0 #-.1*self.rx
                self.ry = 0 #-.1*self.ry
                self.rz = 0 #-.1*self.rz

                self.dx = 1
                self.dy = 1
                self.dz = 1
            else:
                self.trapped = True

    def proximity_check(self):
        box_pos = vector(0, 0, 0)
        box_mass = 10^200

        GRAVC = 6.67e-11

        rVector = self.pos - box_pos
        acc = -((GRAVC * box_mass) / rVector.mag2 )
        acc *= rVector.norm()

        self.pos = self.pos + acc


def shoot_ball():
    ball = Ball()
    balls.append(ball)


scene.autoscale = False


while(True):
    #if i%2 == 0:
    shoot_ball()

    for m in range(len(balls)):
        ball = balls[m-1]

        ball.proximity_check()

        rx = ball.rx
        ry = ball.ry
        rz = ball.rz

        dx = ball.dx
        dy = ball.dy
        dz = ball.dz

        rate(50000)
        ball.pos.x = (dx * ball.pos.x) + (rx*1)
        ball.pos.y = (dy* ball.pos.y) + (ry*1)
        ball.pos.z = (dz * ball.pos.z) - (rz*1)

        ball.collision_check()

    i+=1
