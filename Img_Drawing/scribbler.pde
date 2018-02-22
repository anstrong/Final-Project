public class scribbler {
  private int x;
  private int y;
  private int loc;
  
  private int color_min;
  private int color_max;
  private int average;
  
  private int drawn_lines = 0;
  
  private float thickness;
  private color shade;

  private PVector old_pixel = new PVector(0,0);
  private PVector new_pixel = new PVector(0,0);
  
  public scribbler(int x0, int y0, int low_val, int high_val) {
    x = x0;
    y = y0;
    
    old_pixel = new PVector(x, y);
    
    color_min = low_val;
    color_max = high_val;
    
    thickness = .25-(color_max/500);
    shade = color(average, average, average);
  }  
  
  public PVector get_point(int distance) {
    int lx; // local x
    int ly; // local y
    
    if(distance != 0)
    {
      int x1 = int(old_pixel.x);
      int y1 = int(old_pixel.y);
      
      int[] new_xs = new int[]{x1 + distance, x1, x1 - distance};
      int[] new_ys = new int[]{y1 + distance, y1, y1 - distance};
      
      lx = new_xs[int(random(new_xs.length))];
      ly = new_ys[int(random(new_ys.length))];
    }
    
    else
    {
      lx = int(random(width));
      ly = int(random(height));
    }
    
    PVector point = new PVector(lx, ly);
    return point;
  }
  
  public boolean check_validity(int lx, int ly) {
    color pixel;
    color pixel_color;
    
    boolean black;
    boolean taken;
    
    int loc = lx + ly*width;
    
    if(0 < loc && loc <= img.pixels.length)
    {
      try
      {
        pixel = img.pixels[loc];
      }
      catch(IndexOutOfBoundsException ex)
      {
        return false;
      }
      
      int a = (pixel >> 24) & 0xFF;
      int r = (pixel >> 16) & 0xFF;  // Faster way of getting red(argb)
      int g = (pixel >> 8) & 0xFF;   // Faster way of getting green(argb)
      int b = pixel & 0xFF;          // Faster way of getting blue(argb)
        
      pixel_color = color(r, g, b, a);
      
      black = ((color(color_min, color_min, color_min) <= pixel_color) && (pixel_color <= color(color_max, color_max, color_max)));
      taken = Arrays.asList(covered).contains(loc);
            
      if(black == true && taken == false)
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
    
    int v_loop = 0;
    int d_loop = 0;
    
    int lx = 0;
    int ly = 0;
    
    int distance = 10;
    
    while(valid != true)
    {
      PVector point = get_point(distance);
      
      lx = (int)point.x;
      ly = (int)point.y;
      
      valid = check_validity(lx, ly);
      
      v_loop++;
      
      if(v_loop < 6 || distance == 0)
      {
        if(distance <= (width+height)/1)
        {
          distance++;
        }
        else
        {
           if(d_loop < 1)
           {
             distance = 10;
             v_loop = 0;
             d_loop ++;
           }
           else
           {
             distance = 0;
             v_loop = 0;
             d_loop = 0;
           }
        }
      }
    }
    
    x = lx; // Update object x-value
    y = ly; // Update object y-value
    loc = x + y*width;
    
    covered = expand(covered, covered.length+1);
    covered[covered.length -1] = loc;
    
    x_vals = expand(x_vals, x_vals.length+1);
    x_vals[x_vals.length -1] = loc;
    
    y_vals = expand(y_vals, y_vals.length+1);
    y_vals[y_vals.length -1] = loc;
    
    /*
    PVector coordinate = new PVector(x, y);
    return coordinate;
    */
  }
  
  public void draw_line()
  {
    generate_coordinate();
    
    new_pixel = new PVector(x, y);
  
    float x1, y1, x2, y2;
    
    x1 = old_pixel.x;
    y1 = old_pixel.y;
    x2 = new_pixel.x;
    y2 = new_pixel.y;
    
    colorMode(HSB);
    shade = color(drawn_lines%360, 100, 100);
    
    strokeWeight(thickness);
    stroke(shade);
    
    line(x1,y1,x2,y2);
    drawn_lines += 1;
    
    old_pixel = new_pixel;
  }
}