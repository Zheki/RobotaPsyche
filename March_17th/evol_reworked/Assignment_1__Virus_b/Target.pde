//A simple class for making the target

class Target {
  PVector pos;

  Target(float x, float y) {
    pos = new PVector(x, y);
  }


  void display() {
    
    noStroke();
    fill(150);
    translate(-90,-90);
    cell_body.resize(180,180);
    image(cell_body, pos.x, pos.y);
  }
}
