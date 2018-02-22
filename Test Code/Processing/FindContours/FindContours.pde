import gab.opencv.*;
import processing.video.*;
Movie mov;

PImage src, dst;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;
ArrayList<Float> xpoints;
ArrayList<Float> ypoints;

String PATH = "/Users/annabelle_strong/Documents/GitHub/Final-Project/Dancer.mp4";

void setup() {
  size(1080, 360);
  
  frameRate(30);
  mov = new Movie(this, PATH);
  mov.play();
  mov.speed(10);
  mov.loop();
  mov.volume(0);
}
  
void movieEvent(Movie mov) {
  mov.read();
  mov.loadPixels();
  
  opencv = new OpenCV(this, mov);

  //opencv.gray();
  opencv.threshold(200);
  dst = opencv.getOutput();

  contours = opencv.findContours();
  Contour cnt = contours.get(1);
  System.out.println(cnt.toString());
}

void draw() {
  scale(1);
  image(mov, 0, 0);
  image(dst, mov.width, 0);

  noFill();
  strokeWeight(3);
  
  for(Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
  
  println(xpoints);
}