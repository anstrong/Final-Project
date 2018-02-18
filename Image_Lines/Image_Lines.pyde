def random_point():
    global new_pixel
    
    black = False
    
    while(not black):
        x = int(random(img.width))
        y = int(random(img.height))

        loc = x + y*(img.width)
        
        pixel = img.pixels[loc]
        
        if(pixel == color(0, 0, 0) and loc not in covered):
            covered.append(loc)
            return(x, y)
            black == True
            break
      
def local_point():
    global old_pixel
    
    black = False
    distance = 5
    c = 0
    d = 0
    
    x1 = old_pixel[0]
    y1 = old_pixel[1]
    
    new_xs = [x1 + distance, x1, x1 - distance]
    new_ys = [y1 + distance, y1, y1 - distance]
    
    while(not black):
        in_range = False
        while(not in_range):
            rx = int(random(len(new_xs)))
            ry = int(random(len(new_ys)))
            
            x = new_xs[rx]
            y = new_ys[ry]
            
            print(' ')
            print('x: ' + str(x))
            print('y: ' + str(y))
            
            loc = x + y*(img.width)
            
            if(0 <= loc < len(img.pixels)):
                in_range = True
                break
            else:
                in_rage = False

        pixel = img.pixels[loc]
        
        if(pixel == color(0, 0, 0) and loc not in covered):
            covered.append(loc)
            return(x, y)
            black == True
            break
            
        else:
            black == False
            c += 1
            if(c > 4):
                if(distance <= 100):
                    distance += 1
                else:
                    distance = 1
                    d += 1
                if(d > 2):
                    old_pixel = random_point()
                    print(old_pixel)
                    distance = 5
                    
                print(' ')
                print('new distance: ' + str(distance))
                print(' ')
                c = 0

def generate_coordinate():
    global old_pixel
    
    new_pixel = local_point()

    x1 = old_pixel[0]
    y1 = old_pixel[1]
    x2 = new_pixel[0]
    y2 = new_pixel[1]
    
    print('  ')
    print(old_pixel, new_pixel)
    
    line(x1,y1,x2,y2)
    
    old_pixel = new_pixel

def setup():
    global img
    size(630, 630200)
    img = loadImage("../Girl.jpg")
    background(255)
    
    strokeWeight(1)
    stroke(255, 255, 255)
    
    global old_pixel
    old_pixel = (300, 300)
    
    global new_pixel
    
    global covered
    covered = []
    
def draw():
    image(img, 0, 0)
    loadPixels()
    img.loadPixels()
    stroke(255, 255, 255)
    generate_coordinate()
    
