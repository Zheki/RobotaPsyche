//Class for the viruses.

class Virus {

  DNA dna;

  PVector pos;   //Position of the virus
  PVector vel;   //Velocity of the virus
  PVector accel; //Acceleration of the virus
  float max_speed; //Controlling speed so the bodies don't go too fast.
  float fitness; //Fitness determines survaivability
  int count;     //Simple random numbers
  boolean alive;  //Checking if alive
  boolean is_fit;  //Checking if meets fitness criteria



 //Usual position and speed constructor
  Virus(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
    max_speed = 5;
    alive = true;
    fitness = 1000;                  //Fitness set to highest possible while alive (the larger the number, the less fit)
    dna = new DNA(random(TWO_PI));
  }


  void applyForce(PVector force) {   //Applying force
    accel.add(force);
  }

  void update() {                    //Updating the function, pretty much updates every single process for the vehicle.
    dna = new DNA(random(TWO_PI));   //I placed this here because it was the only way to make the movement wiggle instead of going in a straight line.
    count = (int) random(199);       //Made it random so it does not go out of bounds
    applyForce(dna.direction[count]);
    //println(dna.direction[count]); //Checking the vector values
    vel.add(accel);  
    vel.limit(max_speed);
    pos.add(vel);
    accel.mult(0);
    fitness();
    if (is_fit) {
      dna.getDNA(dna.direction);
    }
  }


//Checking if alive (not off screen)
  void checkDeath() {
    if (pos.x > width || pos.y > height || pos.x < 0 || pos.y < 0) {
      alive = false;
    }
  }

//Checking fitness
  void fitness() {
    if (time == 180) {
      float d = dist(pos.x, pos.y, target.pos.x, target.pos.y);
      fitness = d;
      if (fitness < height/2) {
        println(fitness);
        is_fit = true;
      }
    }
  }

//Displaying the viruses

  void display() {
    pushMatrix();
    stroke(0);
    fill(100, 255, 50);
    translate(pos.x+35, pos.y+35);
    virus_body.resize(70, 70);
    image(virus_body, 0, 0);
    popMatrix();
  }
}
