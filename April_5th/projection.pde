PVector p1, p2, p3, v, u, vm;  //Defining PVectors

void setup() {       
  size(800, 800);   //Setting up screen size
}


void draw() {
  background(200);
                                       //Initializing the locations of the three points 
  p1 = new PVector(50, 50);            
  p2 = new PVector(50, 500);           
  p3 = new PVector(mouseX, mouseY);    
                                       //Calculating vectors v and u
  v = PVector.sub(p3, p1);             //From p1 to p3
  u = PVector.sub(p1, p2);             //From p1 to p2 
  u.normalize();                       //Normalizing u (from p1 to p2)
  vm = u.mult(v.dot(u));               //Projecting v onto u

  line(p1.x, p1.y, p2.x, p2.y);        //Drawing visualization of vectors and projection
  line(p1.x, p1.y, p3.x, p3.y);
  translate(p1.x, p1.y);
  fill(0, 0, 0);
  ellipse(vm.x, vm.y, 30, 30);
  print(vm.y);                         //Printing projection
}
