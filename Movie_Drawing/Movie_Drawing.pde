import com.hamoid.*;
import processing.video.*;
import java.util.Arrays;
/*********************************************************************************/
// TODO
// Test with other videos
// Ask Healey about speed/processing power/efficiency
// Ask Healey about relative file path

Movie mov;
VideoExport videoExport;

// Establish point lists
int[] covered = new int[1];
int[] x_vals = new int[1];
int[] y_vals = new int[1];

///////////////////  CUSTOMIZABILITY
String path = "/Users/annabelle_strong/Documents/GitHub/Final-Project/Movie_Drawing/Media/Dancer.mp4"; // [Silhouette strongly recommended]

int focus_color = color(RGB, 70, 140, 200); // Color to look for in video
int tolerance = 150; // Range from the focus color in which color will still be considered valid

int num = 1000; // Number of "scribblers" (more --> faster, more dense)

String type = "lines"; // "points" vs "lines" as a visualizer
float stroke_thickness = .75; // thickness of lines or points (recommended: .5 - 1 for lines, 1.5 - 2 for points)

int distance = 7; // distance in between points (higher --> less dense for "points", longer lines for "lines"

boolean colored = false; // Black and white or color-change (the color isn't very saturated however; not sure why)
float colored_factor = 1; // graduality of color change (higher --> more gradual)
//boolean individually_colored = false;

int rate = 25; // frame rate (too low --> choppy, too high --> can't process)
float speed = .1; //playback speed (slower --> denser visualizers)


scribbler[] Scribblers = new scribbler[num]; // establish "scribbler" object

/***********************************************************************************/
void setup() {
  size(596, 336); // set window size (same as video file)
  background(255); // set bacground color
  
  stroke(0, 0, 0); // set initial stroke color
  colorMode(HSB); // set color mode: HSB (for one-value color changing)
  
  mov = new Movie(this, path); // create new iteration of Movie object
  videoExport = new VideoExport(this);
  
  frameRate(rate); // set frame rate
  mov.speed(speed); // set video speed 
  
  mov.play(); // play video
  mov.volume(0); // neutralize possible audio
 
  videoExport.startMovie();
  
  for(int i = 0; i < num; i++) // create "num" number of scribblers, give color range for each
  {
    int y_var = 35; // define range from in which origins can be formed
    int y_range = (int)random((height/2 - y_var), (height/2 + y_var));
    
    int x_var = 0;
    int x_range = (int)random((width/2 - x_var), (width/2 + x_var)); 
    
    Scribblers[i] = new scribbler(x_range, y_range); // declare new iterations of scribbler, add to scribbler list
  }
}

void movieEvent(Movie mov) {
  mov.read(); // get frame
  mov.loadPixels(); // get frame pixels for analysis
}

void draw() {
  loadPixels(); 
  
  background(255);
   
  for(int i = 0; i < Scribblers.length; i++) // loop through scribblers
  {
    scribbler scribbler_i = Scribblers[i];
    scribbler_i.draw_line(); // draw visualizers
  }
  videoExport.saveFrame();
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}