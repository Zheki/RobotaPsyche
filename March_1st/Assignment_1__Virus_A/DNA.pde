//Most of my problems are in this class. I am intending to make an array of vectors that would give a direction to each single virus particle.

class DNA {
  
  PVector[] direction = new PVector[200]; 
  float theta_evolved;


  DNA(float theta) {
    
    for ( int i = 0; i < 200; i++) {
      direction[i] = new PVector(cos(theta), sin(theta));
      direction[i].setMag(random(0.3));
    }
  }
  
  DNA getDNA(PVector[] new_direction){
    DNA dna = new DNA(theta_evolved);
    direction = new_direction;
    return dna;
  }

}
