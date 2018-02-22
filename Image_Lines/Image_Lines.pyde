class scribbler():
    def __init__(self, x0, y0, low_val, high_val):
        self.x = x0
        self.y = y0
        self.loc = 0
        
        self.min = low_val
        self.max = high_val
        average = (self.min + self.max)/2
        
        self.thickness = .25-(self.max/500)
        self.color = color(average, average, average)
        
        self.old_pixel = (self.x, self.y)
        self.new_pixel = (self.x, self.y)
        
    def get_point(self, distance):
        global old_pixel
    
        if distance != 0:
            distance = distance
            
            x1 = self.old_pixel[0]
            y1 = self.old_pixel[1]
        
            new_xs = [x1 + distance, x1, x1 - distance]
            new_ys = [y1 + distance, y1, y1 - distance]
            
            rx = int(random(len(new_xs)))
            ry = int(random(len(new_ys)))
            
            x = new_xs[rx]
            y = new_ys[ry]
        else:
            x = int(random(width))
            y = int(random(height))
            
        return(x, y)
    
    def check_validity(self, loc):
        global covered
        
        if(0 < loc <= len(img.pixels)):
            try:
                pixel = img.pixels[loc]
            except IndexError:
                return False
            
            black = (color(self.min, self.min, self.min) <= pixel <= color(self.max, self.max, self.max))
            availible = (loc not in covered)
            
            if(black and availible):
                return True
            else:
                return False
    
    def generate_coordinate(self):
        global covered
        global old_pixel
        global new_pixel
    
        valid = False
        v_loop = 0
        distance = 10
        d_loop = 0
        
        while(not valid):
            pixel = self.get_point(distance)
            
            self.x = pixel[0]
            self.y = pixel[1]
            
            self.loc = self.x + self.y*(width)
            valid = self.check_validity(self.loc)
            
            v_loop += 1
        
            if((v_loop > 6) or (distance == 0)):
                if(distance <= (width+height)/4):
                    distance += 1
                else:
                    if(d_loop < 1):
                        distance = 10
                        v_loop = 0
                        d_loop += 1
                    else:
                        distance = 0
                        v_loop = 0
                        d_loop = 0                  
                
        covered.append(self.loc)
        
        return(self.x, self.y)
        
    def draw_line(self):
        self.new_pixel = self.generate_coordinate()

        x1 = self.old_pixel[0]
        y1 = self.old_pixel[1]
        x2 = self.new_pixel[0]
        y2 = self.new_pixel[1]
        
        strokeWeight(self.thickness)
        stroke(self.color)
        
        line(x1,y1,x2,y2)
        
        self.old_pixel = self.new_pixel

def setup():
    # 2224
    # 1668

    size((630/1), (630/1))
    background(255)
    
    global img
    img = loadImage("../Girl.jpg")
    ratio = 1
    img.resize(img.width/ratio, img.height/ratio);
    
    global covered
    covered = []
    
    global Scribblers
    Scribblers = []
    
    color = False
    
    for i in range(5):
        color_min = 0#i*50
        color_max = 10#(i+1) * 50
        Scribblers.append(scribbler(width/2, height/2, color_min, color_max))
        
    #Scribblers.append(scribbler(width/2, height/2, color(
    
def draw():
    global Scribblers
    
    loadPixels()
    img.loadPixels()
    
    for i in range(len(Scribblers)):
        Scribbler = Scribblers[i]
        
        Scribbler.draw_line()
        
        