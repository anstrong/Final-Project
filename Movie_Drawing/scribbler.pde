public class scribbler {
  private int x; // object current x-value
  private int y; // object current y-value
  private int loc; // object current location in pixel array
  
  private int color_min; // color hue range low
  private int color_max; // color hue range high
  private int average; // average color hue
  
  private int drawn_lines = 0; // iteration counter of "draw_line" function (for color-changing purposes)
  
  private float thickness; // stroke thickness
  private color shade; // stroke shade

  private PVector old_pixel = new PVector(0,0); // old pixel coordinates
  private PVector new_pixel = new PVector(0,0); // latest pixel coordinates
  
  public scribbler(int x0, int y0, int low_val, int high_val) {
    x = x0; // initial x
    y = y0; // initial y
    
    old_pixel = new PVector(x, y); // set "old" location to origin
    
    color_min = low_val; // set inital color values
    color_max = high_val;
    average = low_val/high_val;
    
    thickness = stroke_thickness;
    //thickness = 1;//.25-(color_max/500); // set initial thickness (can tie to grey shade)
    shade = color(average, average, average); // set initial shade
  }  
  
  public PVector get_point(int distance) {
    int lx; // local x
    int ly; // local y
    
    if(distance != 0) // if coming off a previous point...
    {
      int x1 = int(old_pixel.x); 
      int y1 = int(old_pixel.y);
      
      int[] new_xs = new int[]{x1 + distance, x1, x1 - distance}; // set up possibility list of new x-values
      int[] new_ys = new int[]{y1 + distance, y1, y1 - distance}; // set up possibility list of new y-values
      
      lx = new_xs[int(random(new_xs.length))]; // pick random x_value within range
      ly = new_ys[int(random(new_ys.length))]; // pick random y-value within range
    }
    
    else // if totally random point...
    {
      lx = int(random(width)); // pick random x_value within image constraints
      ly = int(random(height)); // pick random y_value within image constraints
    }
    
    PVector point = new PVector(lx, ly); // set up new coordinate value with produced values
    return point;
  }
  
  public boolean check_validity(int lx, int ly) {
    color pixel; // pixel value, returned from pixel array
    color pixel_color; // translated pixel color
    
    boolean correct_color; // whether or not pixel is given color
    boolean taken;  // whether or not pixel has been covered before
    
    int loc = lx + ly*width; // calculate location in pixel array
    
    if(0 < loc && loc <= mov.pixels.length) // if in range...
    {
      try
      {
        pixel = mov.pixels[loc]; // get pixel value
      }
      catch(IndexOutOfBoundsException ex)
      {
        return false;
      }
      
      // translate returned value
      int a = (pixel >> 24) & 0xFF;
      int r = (pixel >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g = (pixel >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b = pixel & 0xFF;          // Faster way of getting blue(argb)
      
      pixel_color = color(r, g, b, a);
      
      // check to see if the pixel fits requirements
      correct_color = ((color(color_min, color_min, color_min) <= pixel_color) && (pixel_color <= color(color_max, color_max, color_max)));
      //correct_color = ((focus_color - color(RGB, 25, 25, 25)) <= pixel_color) && (pixel_color <= focus_color + color(RGB, 15, 15, 15));
      //correct_color = pixel_color < color(255 - tolerance);
      taken = Arrays.asList(covered).contains(loc);
            
      if(correct_color == true && taken == false)
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      return false;
    }
  }
  
  public void generate_coordinate()
  { 
    boolean valid = false;
    
    // counter variables for validity loop and distance-increasing loop respectively
    int v_loop = 0;
    int d_loop = 0;
    
    // local x and y
    int lx = 0;
    int ly = 0;
    
    int l_distance = distance; // set local distance variable to global distance
    
    while(valid != true)
    {
      PVector point = get_point(l_distance); // generate random(ish) point
      
      // update values
      lx = (int)point.x; 
      ly = (int)point.y;
      
      valid = check_validity(lx, ly); // check validity of generated point
      
      v_loop++; // increase counter each time a new point is generated
      
      if(v_loop < 6 || l_distance == 0) // if fewer than 6 points have been generated without meeting requirements OR the point is completely random...
      {
        if(l_distance <= (width+height)/2) // increase search range if it's not already too long
        {
          l_distance++; 
        }
        else
        {
           if(d_loop < 1) // reset search range to search area again if no resets have already occured
           {
             l_distance = 10; 
             v_loop = 0; // reset validity counter; fresh search occuring
             d_loop ++; // increase distance-reset counter
           }
           else // if two searches or area have been conducted, generate completely random point
           {
             l_distance = 0; // tells point-generator to look anywhere on image for new point
             v_loop = 0; // reset counters
             d_loop = 0;
           }
        }
      }
    }
    
    x = lx; // Update object x-value
    y = ly; // Update object y-value
    loc = x + y*width; // update location
    
    covered = expand(covered, covered.length+1); // add location to "covered" list so it's no longer valid to choose
    covered[covered.length -1] = loc;
    
    x_vals = expand(x_vals, x_vals.length+1); // add x-value to "covered" list so it's no longer valid to choose (DEBUGGING)
    x_vals[x_vals.length -1] = loc;
    
    y_vals = expand(y_vals, y_vals.length+1); // add y-value to "covered" list so it's no longer valid to choose (DEBUGGING)
    y_vals[y_vals.length -1] = loc;
  }
  
  public void draw_line()
  {
    generate_coordinate(); // generate valid point
    
    new_pixel = new PVector(x, y); // establish coordinate at updated x and y positions
  
    float x1, y1, x2, y2;
    
    x1 = old_pixel.x; 
    y1 = old_pixel.y;
    x2 = new_pixel.x;
    y2 = new_pixel.y;
    
    if(colored)
    {
      shade = color(drawn_lines%(360 * colored_factor), 100, 100); // update shade (color change feature)
    }

    stroke(shade); // update shade if necessary
    strokeWeight(thickness); // update thickness if necessary
    
    if(type == "points")
    {
      point(x2, y2); // dots as visualizer
    }
    else if(type == "lines")
    {
      line(x1,y1,x2,y2); // lines as visualizer
    }
    
    drawn_lines += 1; // update line counter (color change feature)
    
    old_pixel = new_pixel; // update archived pixel values
  }
}