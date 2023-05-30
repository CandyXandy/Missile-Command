// SOUND
SoundFile smart_bomb_spawn;
SoundFile smart_bomb_explosion;
boolean smart_played;  // required to avoid audio bugs

// LOGIC
int smart_bomb_amount;  // Controls how many smart bombs per level.
int smart_counter;  // times the smart bombs.
int smart_speed = 2;  // Controls smart bomb fall speed.

float[] smart_bomb_exploding;  // Controls if it is exploding.
float[] smart_score_given;  // Makes each smart bomb only give 2 score.
float[] smart_bomb_active;  // Controls drawing of smart bomb.

// SMART_BOMB
float[] smart_x;
float[] smart_y;

int smart_width = 70;
int smart_height = 50;

// VISUAL
PImage smart_bomb;
PImage smart_bomb_exploded;
float[] smart_bomb_blow_up; // explosion size


void setup_smart_bomb() {
  /**
   Initialises variables for smart_bomb.
   Also loads images and sound files.
   
   There are MAXIMUM (2 times level number)
   smart bombs per level.
   Only one smart bomb will be active at any
   given point. Each level will not by any
   means necessarily spawn all available
   smart bombs.
   */

  smart_x = new float[0];
  smart_y = new float[0];

  smart_counter = 650;

  smart_bomb_active = new float[0];
  smart_bomb_blow_up = new float[0];

  smart_bomb_amount = 2 * level_difficulty;

  smart_score_given = new float[0];
  smart_bomb_exploding = new float[0];
  smart_played = false;

  smart_bomb_explosion = new SoundFile(this, "smart_bomb_explosion.wav");
  smart_bomb_spawn = new SoundFile(this, "smart_bomb_spawn.wav");

  smart_bomb_exploded = loadImage("smart_bomb_exploded.png");
  smart_bomb = loadImage("smart_bomb.png");
}


void smart_counter() {
  /**
   Times the spawning of the smart bombs.
   
   This function checks if there are any
   smart bombs available to drop, and
   if so, it counts up to 1000. Once it
   reaches 1000, it appends the necessary
   variables to spawn a smart bomb, and
   makes sure it only spawns on the left
   or right of the cannon platform.
   */
  if (smart_bomb_amount != 0) {
    smart_counter += 1;

    if (smart_counter == 1000) {  // if the counter has reached 1000 ..
      smart_bomb_active = append(smart_bomb_active, 1);  // .. spawn the smart bomb.
      smart_score_given = append(smart_score_given, 0);

      smart_bomb_exploding = append(smart_bomb_exploding, 0);
      smart_bomb_blow_up = append(smart_bomb_blow_up, 1);

      no_centre = int(random(2)); // flips a coin
      if ( no_centre >= 1) { // if heads spawn on right of platform.
        smart_x = append(smart_x, random(right_centre, width - 100));
      } else if (no_centre < 1) {  // if tails spawn on the left.
        smart_x = append(smart_x, random(100, left_centre));
      }
      smart_y = append(smart_y, 0);

      smart_played = false;

      smart_counter = 0; // begin the count to 100 again.

      smart_bomb_amount -= 1;
    }
  }
}


void smart_bomb() {
  /**
   Facilitates the behaviour of smart bombs.
   
   Once the smart bomb is active, the function draws the
   image of the smart bomb, and plays some audio.
   Once the smart bomb has reached the terrain, the function
   deactivates the smart bomb and starts its explosion.
   */
  for (int i = 0; i < smart_x.length; i++) {
    if (smart_bomb_active[i] == 1) {
      if (!smart_played) {  // makes sure audio isn't hurting your ears.
        smart_bomb_spawn.play();
        smart_played = true;
      }

      image(smart_bomb, smart_x[i], smart_y[i], smart_width, smart_height);
      smart_y[i] += smart_speed;
    }
    if (smart_y[i] >= terrain_y && smart_bomb_active[i] != 0) {
      // if the smart bomb has hit the terrain ..
      smart_bomb_active[i] = 0;  // .. it is no longer being drawn ..
      smart_bomb_exploding[i] = 1; // .. and is now exploding!
    }

    collision_city_smart();
  }
}


void smart_bomb_explode() {
  /**
   Controls the explosion of the smart bomb.
   
   Checks to make sure that the smart bomb has
   it's variables at the proper values to
   facilitate an explosion. If all tests pass,
   it draws the explosion to the screen.
   Once the explosion has reached sufficient size,
   the flag is set to false so that it stops.
   */
  for ( int i = 0; i < smart_x.length; i++) {
    if (smart_bomb_active[i] != 1 && smart_bomb_exploding[i] != 0) {
      // If the smart bomb is not active and is exploding ..
      image(smart_bomb_exploded, smart_x[i], smart_y[i],
        smart_bomb_blow_up[i], smart_bomb_blow_up[i]);

      smart_bomb_blow_up[i] += 1;

      if (smart_bomb_blow_up[i] >= 100) {
        smart_bomb_exploding[i] = 0;
      }
    }
  }
}
