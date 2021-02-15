//Zheki 15.02.2021

PImage rocket;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

FlowField flowfield;
Vehicle vehicle;
boolean view_vec = false;

void setup() {
  size(800, 800);
  flowfield = new FlowField(10);
  rocket = loadImage("rocket.png");
  vehicle = new Vehicle(width/2, height/2);
}

void draw() {
  background(255);
  
  for (Vehicle vehicles : vehicles) { 
    vehicles.update();  
    vehicles.display();
    vehicles.follow(flowfield); 
  }
  
  flowfield.init();
  if (view_vec == true) {
    flowfield.display();
  }
}


class FlowField {

  
  PVector[][] field;
  int cols, rows;
  int resolution; 

  FlowField(int r) {
    resolution = r;
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
    init();
  }

  void init() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        float x = i*resolution;
        float y = j*resolution;
        PVector v = new PVector(mouseX-x, mouseY-y);
        v.normalize();
        field[i][j] = v;
      }
    }
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }

  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }

  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 10;
    translate(x, y);
    stroke(0, 100);
    rotate(v.heading2D());
    float len = v.mag()*scayl;
    line(0, 0, len, 0);
    line(len, 0, len-arrowsize, +arrowsize/2);
    line(len, 0, len-arrowsize, -arrowsize/2);
    popMatrix();
  }
}

class Vehicle {

  PVector pos;
  PVector vel;
  PVector accel;
  float max_speed;
  float max_force;
  float r;

  Vehicle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
    max_speed = 3;
    max_force = 10;
  }

  void update() {
    vel.add(accel);
    vel.limit(max_speed);
    pos.add(vel);
    accel.mult(0);
  }

  void applyForce(PVector force) {
    accel.add(force);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    desired.normalize();
    desired.mult(max_speed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(max_force);
    applyForce(steer);
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(pos);
    desired.mult(max_speed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(max_force);
    applyForce(steer);
  }

  void display() {
    float theta = vel.heading() + PI/2;
    fill(175);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    image(rocket, 0, 0, 50, 80);
    popMatrix();
  }
}


void keyPressed() {
  
  if (key == 'd') {
    view_vec = !view_vec;
  }

  if (key == 'r') {
    vehicles.remove(0); 
  }

  if (key =='a') {
    vehicles.add(new Vehicle(width/2, height/2));
    vehicle.display();
  }
}
