ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();

FlowField flowfield;
Vehicle vehicle;
boolean view_vec = false;

void setup() {
  size(800, 800);
  flowfield = new FlowField(20);
  rocket = loadImage("rocket.png");
  vehicle = new Vehicle(mouseX, mouseY);
  for (int i = 0; i < 100; i++) {
    vehicles.add(new Vehicle(random(width), random(height)));
  }
}


void draw() {
  background(255);

  for (Vehicle vehicles : vehicles) {  //use an enhanced loop to cycle through the vehicles
    vehicles.update(); 
    vehicles.display();
    vehicles.follow(flowfield);  //have the vehicles follow the flowfield
    vehicles.applyBehaviors();
  }

  flowfield.perlinNoise();
  if (view_vec == true) {
    flowfield.display();
  }
}

class DNA {
  float size = random(10, 50);
  float health = random(10, 100);
  float speed = random(10, 50);

  float inherit_size() {
    return size;
  }

  float inherit_health() {
    return health;
  }

  float inherit_speed() {
    return speed;
  }
}


class FlowField {

  // A flow field is a two dimensional array of PVectors
  PVector[][] field;
  int cols, rows; // Columns and Rows
  int resolution; // How large iscell" of the flow field

  FlowField(int r) {
    resolution = r;
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
    //followMouse();
    perlinNoise();
  }

  void followMouse() {
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

  void perlinNoise() {

    //float xoff = 0.01;//random();
    float xoff = random(1);
    for (int i = 0; i < cols; i++) {
      //float yoff = 0.01; //random(30);
      float yoff = random(0.5); //random(30);
      for (int j = 0; j < rows; j++) {

        // Moving through the noise() space in two dimensions
        // and mapping the result to an angle between 0 and 360
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);

        // Convert the angle (polar coordinate) to Cartesian coordinates
        field[i][j] = new PVector(cos(theta), sin(theta));

        // Move to neighboring noise in Y axis
        yoff += 0.1;
      }

      // Move to neighboring noise in X axis
      xoff += 0.1;
    }
  }


  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }

  // Draw every vector
  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }

  // Renders a vector object 'v' as an arrow and a position 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 10;
    // Translate to position to render vector
    translate(x, y);
    stroke(0, 100);
    // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
    rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    line(0, 0, len, 0);
    line(len, 0, len-arrowsize, +arrowsize/2);
    line(len, 0, len-arrowsize, -arrowsize/2);
    popMatrix();
  }
}

class Vehicle {

  DNA dna;

  PVector pos;
  PVector vel;
  PVector accel;
  float max_speed;
  float max_force;
  float r;
  float size;
  float health;
  float speed;


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

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, pos);
    desired.normalize();
    desired.mult(max_speed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(max_force);
    return steer;
  }

  PVector follow(FlowField flow) {
    // Look up the vector at that spot in the flow field
    PVector desired = flow.lookup(pos);
    desired.mult(max_speed);

    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, vel);
    steer.limit(max_force);
    return steer;
  }

  void applyBehaviors() {
    PVector follow = follow(flowfield);
    applyForce(follow);
  }

  void getDNA() {
    size = dna.inherit_size();
    health = dna.inherit_health();
    speed = dna.inherit_speed();
  }

  void display() {
    float theta = vel.heading() + PI/2;
    fill(0, 200, 0);
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    circle(0, 0, 50);    //This is where I would use the inherited size (instead of the fixed 50)
    popMatrix();
  }
}


void keyPressed() {

  if (key == 'd') {
    view_vec = !view_vec;
  }

  if (key == 'r') {
    vehicles.remove(0); // remove the first vector
    println("removed the first PVector, size is now " + vehicles.size());
  }

  if (key =='a') {
    vehicles.add(new Vehicle(mouseX, mouseY));
    vehicle.display();
  }
}
