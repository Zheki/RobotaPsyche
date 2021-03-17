//Class for the viruses.

class Virus {

  DNA dna;

  // things that change
  PVector pos;   //Position of the virus
  PVector vel;   //Velocity of the virus
  PVector accel; //Acceleration of the virus
  float fitness; //Fitness determines proximity to cell
  int count;     //Simple random numbers
  boolean alive;  //Checking if alive
  boolean is_fit;  //Checking if meets fitness criteria
  PVector[] direction = new PVector[200]; //An array of directions.

  // things that don't change
  float max_speed; //Controlling speed so the bodies don't go too fast.
  color clr;       //Color of the virus
  float size;      //Size of the virus


  Virus(float x, float y, float s, color c) {  //This is the constructor for the new generation of viruses
    pos = new PVector(x,y);
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
    max_speed = 15;
    size = s;
    clr = c;
    alive = true;
    fitness = 1000;
    dna = new DNA(size, c);
  }


  void applyForce(PVector force) {   //Applying force
    accel.add(force);
  }

  void changeDirection() {           //Moving the viruses
    for ( int i = 0; i < 200; i++) {
      direction[i] = new PVector(cos(random(TWO_PI)), sin(random(TWO_PI)));
      direction[i].setMag(random(0.3));
    }
  }

    void update() {                    //Updating the function, pretty much updates every single process for the vehicle.
      count = (int) random(200);
      changeDirection();               
      applyForce(direction[count]);
      vel.add(accel);  
      vel.limit(max_speed);
      pos.add(vel);
      accel.mult(0);
    }


    //Checking if alive (not off screen)
    void checkDeath() {
      if (pos.x > width || pos.y > height || pos.x < 0 || pos.y < 0) {
        alive = false;
      }
    }

    //Checking fitness
    void fitness() {
      float d = dist(pos.x, pos.y, target.pos.x, target.pos.y);
      fitness = d;
      if (fitness < 150) {
        is_fit = true;
      }
    }


    //Displaying the viruses

    void display() {
      pushMatrix();
      stroke(0);
      fill(clr);
      translate(pos.x+100, pos.y+100);
      println(pos.x, pos.y);
      ellipseMode(CENTER);
      ellipse(0, 0, size, size);
      popMatrix();
    }

    DNA getDNA() {
      return(dna.getDNA());
    }
  }
