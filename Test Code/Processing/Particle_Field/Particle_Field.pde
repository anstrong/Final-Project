int cols;
int rows;

int noOfPoints = 4000;

Particle[] particles = new Particle[noOfPoints];
PVector[] flowField;

void setup() {
  size(1000, 760, P2D);
  orientation(LANDSCAPE);
  
  background(0);
  
  flowField = new PVector[(cols*rows)];
  
  for(int i = 0; i < noOfPoints; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
 fill(0,7);
 rect(0,0,width,height);
 noFill();
  
  for(int i = 0; i < particles.length; i++) {
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].edges();
    particles[i].show();
  }
}