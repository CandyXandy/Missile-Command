// SHOT
float[] shootX;   // ABM coordinates
float[] shootY;
int shot_dims = 5;

// TARGET
float[] targX;   //store mouse positions
float[] targY;

// LOGIC
float[] travel;   // Used as boolean, 1 = travelling. 0 = finished travelling
PVector shootDir;   //direction of shot
float shootSpeed = 5;
float[] shoot_explode;  // Controls explosion of ABMs.
float[] shoot_blow_up;  // Size of ABM explosion.

// COLOR
color red = #A01D1D;

// SOUND
SoundFile shoot;
SoundFile shoot_explode_noise;
int soundState;

void setup_shoot() {

  /** 
    Initialises variables for the ABM.
    Also loads images and sound files.
   */

  shootX = new float[0];
  shootY = new float[0];

  travel = new float[0];
  shoot_explode = new float[0];
  shoot_blow_up = new float[0];

  targX = new float[0];
  targY = new float[0];

  shoot = new SoundFile(this, "laser.mp3");
  shoot_explode_noise = new SoundFile(this, "shoot_explosion.wav");
}


void cannon_shoot() {

  /** Facilitates movement and creation of cannon shot
   
   This function iterates over how many shots are in
   the air, and then checks if those particular shots
   are currently travelling. If not , it finds the vector
   between the target and the end of the cannon barrel,
   and creates a shot. It then checks if the length of
   the vector is greater than 0, and normalises the
   vector values between 0 and 1, multiplaying that by
   either ShootSpeed or Shootdir.mag(), whichever is
   smaller. Then the coordinates of the shot are
   incremented by the new values in the shootDir vector.
   Once it has finished travelling along its path, the
   variable travel is set to 0.
   */

  strokeWeight(shot_dims);   // make shots larger
  fill(white);

  for (int i = 0; i < shootX.length; i++) {
    if (travel[i] != 0) {   // has shot finished travelling?

      shootDir = new PVector(targX[i] - shootX[i], targY[i] - shootY[i]);   // determine vector
      stroke(white);
      point(shootX[i], shootY[i]);

      if (shootDir.mag() > 0.0) {   // if length of vector is greater than 0

        shootDir.normalize();   // map values between 0 and 1
        shootDir.mult(shootSpeed);   // multiply by shootSpeed

        shootX[i] += shootDir.x;  // increment by vector values
        shootY[i] += shootDir.y;

        if (shootX[i] >= (targX[i] - 2.5) &&   // if the shot reaches the end of its path
          shootX[i] <= (targX[i] + 2.5) &&
          shootY[i] >= (targY[i] - 2.5) &&
          shootY[i] <= (targY[i] + 2.5)) {

          shoot_explode[i] = 1;  // shot is exploding!
          soundState = 0;  // play the sound!
          
          travel[i] = 0;   // finished travelling
        }
      }
    }
    if (shoot_explode[i] == 1) {
      shoot_explode();
    }
  }
}


void shoot_explode() {
  /*
    Facilitates the explosion of the ABM shot.
    
    First of all, only allows the explosion noise to play once per shot.
    Then this function checks to make sure that travel == 0 and that
    shoot_explode is == 1. If so, it then creates a red ellipses that
    represents the explosion of the shot.
    Bombs can only be intercepted within this explosion.
  */
  
  if (soundState < 1) {   // prevents explosion noise from destroying your ears.
    shoot_explode_noise.play();
    soundState ++;
  }
  
  for (int i = 0; i < shootX.length; i++) {
    if (travel[i] != 1 &&
      shoot_explode[i] != 0) {   // if bomb finished travelling, and has started exploding

      noStroke();
      fill(red);
      ellipse(targX[i], targY[i], shoot_blow_up[i], shoot_blow_up[i]);

      shoot_blow_up[i] += 5;

      if (shoot_blow_up[i] >= 100) {  // if explosion becomes too large..
        shoot_blow_up[i] = 0;         // stop it.
        shoot_explode[i] = 0;
      }
    }
  }
}
