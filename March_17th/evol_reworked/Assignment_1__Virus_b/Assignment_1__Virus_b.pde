PImage cell_body;

Virus virus;
Target target;
ArrayList<Virus> viruses = new ArrayList<Virus>();
int population_size = 15;
int time = 0;




void setup() {
  size(1000, 700);
  cell_body = loadImage("cell.png");
  target = new Target(100, height/2);
  for (int i = 0; i < population_size; i++) {
    viruses.add(new Virus(width-100, random(height), random(30, 80), color(random(255))));    //Spawning of initial viruses with random values for color, size, and max speed)
  }
}

void draw() {
  background(255);
  target.display();


  for (int i = 0; i < viruses.size(); i++) {
                                                  //This happens throughout the life of the generation
    Virus virus = viruses.get(i);
    virus.update();
    virus.display();
    virus.checkDeath();
    virus.fitness();
    time = frameCount%5;                          //If virus stays for 5 seconds within the cell's proximity, it reproduces.
    if (time == 0) {        
      if (virus.is_fit == true) {                 //The viruses proximity is determined by it's fitness, which in this case means how close to the cell it got.
        DNA dna = virus.getDNA();                 //Get the DNA of the virus(its size and color) and make more viruses.
        viruses.add(new Virus(width-100, random(200, height-200), dna.size, dna.clr));
      }
    }

    if (virus.alive == false) {
      viruses.remove(virus);                      //if the virus is dead (which in this case is by leaving the screen
    }
  }
}

void mouseClicked() {
  viruses.add(new Virus(mouseX, mouseY, random(30, 80), color(random(255))));   //If mouse clicked spawn a virus 
}

void keyPressed() {
  if (key == DELETE) {                                                         //If Delete is pressed, remove all viruses
    viruses.clear();
  }
}
