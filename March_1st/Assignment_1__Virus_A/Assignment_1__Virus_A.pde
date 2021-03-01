PImage cell_body;
PImage virus_body;

Virus virus;
Target target;
ArrayList<Virus> viruses = new ArrayList<Virus>();
int population_size = 15;
int time = 0;




void setup() {
  size(1000, 700);
  cell_body = loadImage("cell.png");
  virus_body = loadImage("virus_body.png");
  virus = new Virus(width-100, height/2);
  target = new Target(100, height/2);
  for (int i = 0; i < population_size; i++) {
    viruses.add(new Virus(width-100, height/2));
  }
}

void draw() {
  background(255);
  //Timer counts down every 200 frames
  time = frameCount%200;
  if (time == 0) {
    viruses.clear();
    for (int i = 0; i < population_size; i++) {
      viruses.add(new Virus(width-100, height/2));
    }
  }
  
  target.display();

//
  for (int i = 0; i < viruses.size(); i++) {
    Virus virus = viruses.get(i);
    virus.update();
    virus.display();
    virus.checkDeath();
    
    if (virus.alive == false) {
      viruses.remove(virus);
    }
  }
}
