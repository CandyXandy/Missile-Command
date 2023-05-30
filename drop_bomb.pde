// SOUND //<>//
import processing.sound.*;
SoundFile explosion;
boolean bomb_sound_playing;  // stop audio glitches

//LOGIC
float[] bomb_blow_up; // explosion size.
float[] boolean_bomb; // controls drawing of bomb.
float[] boolean_explode; // controls whether bomb is exploding.
float[] score_given; // Used to make sure missiles only give 1 score.

int counter = 0;  // used to time bomb drops.
int bomb_count;  // number of bombs for the level.

int bomb_speed = 2;  // controls fall speed of bombs.

// LOCATION LOGIC
float no_centre;
int right_centre;
int left_centre;

//BOMB
float[] bomb_x;
float[] bomb_y;

//DIMENSIONS
int bomb_width = 70;
int bomb_height = 60;

//VISUAL
PImage bomb;
PImage bomb_exploded;


void setup_bomb() {
  /**
   Initialises variables and loads images for bombs
   as well as the sound files for the explosion.
   
   Each level has the (level number times 10) bombs
   to drop.
   */
  bomb_x = new float[0];
  bomb_y = new float[0];
  
  right_centre = (width/2) + 35;
  left_centre = (width/2) - 35;
  
  bomb_count = 10 * level_difficulty;

  explosion = new SoundFile(this, "explosion.mp3");

  imageMode(CENTER);
  bomb_exploded = loadImage("bomb_exploded.png");
  bomb = loadImage("bomb.png");

  boolean_bomb = new float[0];
  bomb_blow_up = new float[0];
  boolean_explode = new float[0];
  score_given = new float[0];

  bomb_sound_playing = false;
}


void bomb_counter() {
  /**
   Used to time bomb drops.
   
   Uses the counter variable to drop a bomb
   approximately every second and a half.
   Appends the appropriate arrays and checks
   if there are bombs remaining to drop.
   Can't drop more bombs if there aren't any!
   Only drops bombs left or right of the cannon
   platform.
   
   If we run out of bombs to drop,
   calls level_change().
   */
  counter += 1;

  if (counter >= 100) {
    if (bomb_count > 0) {  // if there bombs left
      no_centre = int(random(2));  // flip a coin
      if (no_centre >= 1) { // if heads..
        // spawn this bomb on right.
        bomb_x = append(bomb_x, random(right_centre, width-100));
      } else if (no_centre < 1) {  // if tails
        // spawn this bomb on left.
        bomb_x = append(bomb_x, random(100, left_centre));
      }
      bomb_y = append(bomb_y, 0);
      
      boolean_bomb = append(boolean_bomb, 1);
      bomb_blow_up = append(bomb_blow_up, 3);
      boolean_explode = append(boolean_explode, 0);
      score_given = append(score_given, 0);

      counter = 0;
      
      bomb_count --;
    }
    if (bomb_count <= 0) {
      level_change();  // if there are no bombs left, call level change.
    }
  }
}



void create_bomb() {
  /**
   Creates the bombs themselves and controls their behaviour.
   
   Checks for each bomb if that particular bomb is active,
   and if so, draws it on the screen and drops it down
   the screen, as well as setting bomb_blow_up to 0.
   It then checks if the height of the bomb has reached
   the terrain and setting boolean_explode for that
   respective bomb to 1, and boolean_bomb to 0, which
   stops it from being considered for collision or being
   drawn on the screen.
   If boolean_explode is equal to one, it calls
   bomb_explode().
   
   The collision functions are also called here as they
   can occasionally cause index errors if called in the
   main loop. This prevents that entirely.
   */
  for (int i = 0; i < bomb_x.length; i++) {
    if (boolean_bomb[i] != 0) {  // if bomb is active ..

      image(bomb, bomb_x[i], bomb_y[i],
      bomb_width, bomb_height); // .. draw the bomb ..
      
      bomb_y[i] += bomb_speed;  // .. and drop it down the screen.
      
      bomb_blow_up[i] = 0;  // prepare explosion size to 0.

      if (bomb_y[i] >= terrain_y) {  // if bomb hits terrain ..
        boolean_explode[i] = 1;  // .. bomb is now exploding! ..
        boolean_bomb[i] = 0;  // .. and is now longer being drawn.
        explosion.play();
      }
    }
    if (boolean_explode[i] == 1) {
      bomb_explode();
    }
  }
  collision(); // start to call collision when create_bomb is ..
  collision_city();  // .. initially called so we don't have index errors.
}


void bomb_explode() {

  /**
   Creates the actual explosion animation of the bomb.
   
   Checks to make sure when called that boolean_bomb
   and boolean_explode are set to their proper values
   to facilitate an explosion. If they are, the
   function displays the explosion image and makes it grow.
   
   Once it has reached a sufficient size, boolean_explode
   is set to 0 so that the image is no longer drawn.
   */

  for (int i = 0; i < bomb_x.length; i++) {
    if (boolean_bomb[i] != 1 &&  // if bomb is not active and is exploding ..
      boolean_explode[i] != 0) {
      image(bomb_exploded, bomb_x[i], bomb_y[i], bomb_blow_up[i], bomb_blow_up[i]);
      // .. draw the explosion!
      bomb_blow_up[i] += 1;

      if (bomb_blow_up[i] >= 200) {

        boolean_explode[i] = 0;
      }
    }
  }
}
