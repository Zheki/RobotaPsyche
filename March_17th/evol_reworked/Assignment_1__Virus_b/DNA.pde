//Most of my problems are in this class. I am intending to make an array of vectors that would give a direction to each single virus particle.

class DNA {
  float size;
  color clr;

  DNA(float s, color c) {

    for ( int i = 0; i < 200; i++) {
      size = s;
      clr = c;
      mutation();   //Applying mutation.
    }
  }

  //A function for getting the DNA
  DNA getDNA() {  
    DNA dna = new DNA(size, clr);
    return dna;
  }


  void mutation() {          //Mutating size and color
    clr += random(-20, 20);
    size += random(-5, 5);
  }
}
