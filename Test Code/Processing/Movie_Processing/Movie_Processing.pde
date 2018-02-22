import processing.video.*;
Movie mov;

String PATH = "/Users/annabelle_strong/Documents/GitHub/Final-Project/Dancer.mp4";

void setup() {
  size(640, 360);
  frameRate(10);
  mov = new Movie(this, PATH);
  mov.play();
  mov.speed(0);
  mov.loop();
  mov.volume(0);
}

void pixel_to_point() {
}

void find_silhouette() {
  int silhouette[];
  
  int numPixels = mov.width * mov.height; 
  
  for (int i = 0; i < numPixels; i++)
  {
    color pixel = mov.pixels[i];
    if (pixel == color(0, 0, 0))
    {
      System.out.println("black");
    }
    else
    {
      System.out.println("white");
    }
  }
}

void movieEvent(Movie mov) {
  
    
  mov.read();
  mov.loadPixels();
 
}

void draw() {
  image(mov, 0, 0, width, height);
}