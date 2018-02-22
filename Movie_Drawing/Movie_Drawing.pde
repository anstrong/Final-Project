import processing.video.*;
import java.util.Arrays;
/*********************************************************************************/
// TODO
// Video export
// GUI
// Test with other videos
// Ask Healey about speed/processing power/efficiency

Movie mov;

// Establish point lists
int[] covered = new int[1];
int[] x_vals = new int[1];
int[] y_vals = new int[1];

///////////////////  CUSTOMIZABILITY
String path = "/Users/annabelle_strong/Documents/GitHub/Final-Project/Movie_Drawing/Dancer.mp4"; // [Silhouette strongly recommended]

int num = 1600; // Number of "scribblers" (more --> faster, more dense)

String type = "points"; // "points" vs "lines" as a visualizer
int stroke_thickness = 1;

int distance = 5; // distance in between points (higher --> less dense for "points", longer lines for "lines"
String concentration = "swarm"; // "swarm" vs "solid"; changes how frequently canvas is erased

boolean colored = true; // Black and white or color
int colored_factor = 2; // graduality of color change (higher --> more gradual)
//boolean individually_colored = false;

int rate = 25; // frame rate (too low --> choppy, too high --> can't process)
float speed = .15; //playback speed (slower --> denser visualizers)


scribbler[] Scribblers = new scribbler[num]; // establish "scribbler" object

/***********************************************************************************/
void setup() {
  size(596, 336); // set window size (same as video file)
  background(255); // set bacground color
  
  stroke(0, 0, 0); // set initial stroke color
  colorMode(HSB); // set color mode: HSB (for one-value color changing)
  
  mov = new Movie(this, path); // create new iteration of Movie object
  
  frameRate(rate); // set frame rate
  mov.speed(speed); // set video speed 
  
  mov.play(); // play video
  mov.volume(0); // neutralize possible audio
  //mov.loop(); // loop video
  
  for(int i = 0; i < num; i++) // create "num" number of scribblers, give color range for each
  {
    int color_min = 0; // can base off of i for unique scribbler colors (best for low "num")
    int color_max = 10;
    
    int a = (int)Math.pow(-1, i); // alternate between positive and negative values
    int b = i%5; // return tp image origin after an increase or decrease of 100
    
    //int variation = (a * 25 * b); // vary the origin of each "scribbler" for fuller image; increase or decrease by 25 each time
    int variation = 0;
    
    Scribblers[i] = new scribbler(width/2, height/2 + variation, color_min, color_max); // declare new iterations of scribbler, add to scribbler list
  }
}

void movieEvent(Movie mov) {
  mov.read(); // get frame
  mov.loadPixels(); // get frame pixels for analysis
  
  if(concentration == "solid")
  {
    background(255); // solid effect when up here
  }
}

void draw() {
  loadPixels(); 
  
  if(concentration == "swarm")
  {
    background(255);
  }
   
  for(int i = 0; i < Scribblers.length; i++) // loop through scribblers
  {
    scribbler scribbler_i = Scribblers[i];
    scribbler_i.draw_line(); // draw visualizers
  }
}