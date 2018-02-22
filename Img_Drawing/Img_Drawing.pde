import g4p_controls.*;
import java.util.Arrays;

PImage img;

int[] covered = new int[1];
int[] x_vals = new int[1];
int[] y_vals = new int[1];
int num = 1000;

scribbler[] Scribblers = new scribbler[num];

void setup() {
  size(630, 630);
  
  background(255);
  colorMode(HSB);
  stroke(0, 0, 0);
  strokeJoin(ROUND);
  strokeJoin(ROUND);
  
  img = loadImage("/Users/annabelle_strong/Documents/GitHub/Final-Project/Media/Girl.jpg");
  
  for(int i = 0; i < num; i++)
  {
    int color_min = 0;
    int color_max = 10;
    
    Scribblers[i] = new scribbler(width/2, height/2, color_min, color_max);
  }
}

void draw() {
  img.loadPixels();
  loadPixels();
   
  for(int i = 0; i < Scribblers.length; i++)
  {
    scribbler scribbler_i = Scribblers[i];
    scribbler_i.draw_line();
  }
}