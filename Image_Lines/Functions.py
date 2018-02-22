class scribbler():
    def __init__(self, x0, y0):
        self.x = x0
        self.y = y0
        self.loc
        
        self.old_pixel = (self.x, self.y)
        self.new_pixel
        
    def get_point(distance):
        global old_pixel
    
        if distance != 0:
            distance = distance
            
            x1 = old_pixel[0]
            y1 = old_pixel[1]
        
            new_xs = [x1 + distance, x1, x1 - distance]
            new_ys = [y1 + distance, y1, y1 - distance]
            
            rx = int(random(len(new_xs)))
            ry = int(random(len(new_ys)))
            
            x = new_xs[rx]
            y = new_ys[ry]
        else:
            x = int(random(img.width/2))
            y = int(random(img.height/2))
            
        return(x, y)
    
    def check_validity(loc):
        global covered
        
        if(0 < loc <= len(img.pixels)):
            pixel = img.pixels[loc]
            
            black = (color(0, 0, 0) <= pixel <= color(50, 50, 50))
            availible = (loc not in covered)
            
            if(black and availible):
                return True
            else:
                return False
    
    def generate_coordinate():
        global covered
        global old_pixel
        global new_pixel
    
        valid = False
        v_loop = 0
        distance = 10
        d_loop = 0
        
        while(not valid):
            pixel = get_point(distance)
            
            self.x = pixel[0]
            self.y = pixel[1]
        
            print(' ')
            print('x: ' + str(x))
            print('y: ' + str(y))
            
            self.loc = x + y*(img.width)
            valid = check_validity(loc)
            
            v_loop += 1
        
            if((v_loop > 6) or (distance == 0)):
                if(distance <= 500):
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
        
    def draw_line():
        self.new_pixel = generate_coordinate()

        x1 = self.old_pixel[0]
        y1 = self.old_pixel[1]
        x2 = self.new_pixel[0]
        y2 = self.new_pixel[1]
        
        line(x1,y1,x2,y2)
        
        self.old_pixel = self.new_pixel