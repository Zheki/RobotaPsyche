PImage car;
Vehicle v;

void setup() {
  size(1080, 768);
  v = new Vehicle();
  car = loadImage("car.png");
}

void draw() {
  background(0, 0, 200);
  PVector force = new PVector(0, 0);
  v.update();
  v.border();
  v.display();
  v.applyForce(force);
}

class Vehicle {
  PVector position;
  PVector throttle;
  PVector velocity;
  float cap = 10;

  Vehicle() {
    velocity = new PVector(0, 0);
    throttle = new PVector(0, 0);
    position = new PVector(width/2, height/2);
  }


  void display() {
    float theta = velocity.heading() + PI/2;
    imageMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    image(car, 0, 0, 50, 80);
    popMatrix();
  }

  void update() {
    velocity.add(throttle);
    position.add(velocity);
    throttle.mult(0);
    velocity.limit(cap);
  }

  void applyForce(PVector force) {
    throttle.add(force);
  }


  void border() {
    if (position.x > width) {
      position.x = 0;
    }

    if (position.y > height) {
      position.y = 0;
    }

    if (position.x < 0) {
      position.x = width - 1;
    }

    if (position.y < 0) {
      position.y = height - 1;
    }
  }
}


void keyPressed() {
  if (keyCode == UP) {
    v.throttle.y = -0.3;
  }
  if (keyCode == DOWN) {
    v.throttle.y = 0.3;
  }
  if (keyCode == LEFT) {
    v.throttle.x = -0.3;
  }
  if (keyCode == RIGHT) {
    v.throttle.x = 0.3;
  }
}
