/*#################################################################
 # COSC 101 - GROUP 31 - Alexander.R - Will.D - David.A           #
 # Assignment 3 - Missile Command.                                #
 # A recreation of the Atari 2600 video game Missile Command.     #
 # This game is a non-faithful recreation of Missile Command on   #
 # the Atari 2600, with some game design choices realigned to     #
 # our own vision.                                                #
 # Sound supplied by freesound.org.                               #
 # Images supplied by stockfreeimages.com                         #
 # To run this program you will need the sound library,           #
 # which can be obtained via the Tools tab at the top of your     #
 # Processing IDE. Pressing play in the top left corner will      #
 # begin the game.                                                #
 # Video reflection: https://youtu.be/6-Joi0zCrX8                 #
 # Video embed link to the right of header box.                   #
 ################################################################*/


// LEVEL NUMBER
int level_difficulty = 1; // controls current level


void setup() {
  /**
   Initialises the variables needed for each level change
   and for the start of the game.
   */
  background(0);  // background when not in gameplay.
  frameRate(60);
  size(800, 800);

  setup_sounds();

  setup_bomb();
  setup_smart_bomb();

  setup_cannon();
  setup_shoot();

  setup_buildings();
  setup_terrain();
  setup_trees();

  setup_ammo();
}


void draw() {
  /**
   Main program loop.
   */
  if (!start) {
    start_screen();  // display start screen
  } else {
    if (level_screen) {
      level_screen();  // display level change screen
    } else {
      if (game_over) {
        game_over();  // display game over screen
      } else {
        if (end_game) {
          end_game();  // display end of game screen
        } else {
          if (level_difficulty == 1) {   // background changes with level
            background(bg_colour1);
          } else if (level_difficulty == 2) {
            background(bg_colour2);
          } else if (level_difficulty == 3) {
            background(bg_colour3);
          }

          draw_terrain();
          draw_buildings();
          draw_trees();

          bomb_counter();
          create_bomb();

          smart_counter();
          smart_bomb();
          smart_bomb_explode();

          render_cannon();
          cannon_shoot();

          display_score();
          display_ammo();

          if (allZeroI(bottom_building) && allZeroI(top_building)) {
            // if all buildings are destroyed..
            game_over = true; // .. Game Over!
          }
        }
      }
    }
  }
}


void mousePressed() {
  /** Stores a number of variables for cannon shot.
   
   Upon mouse click, appends the arrays 'targ',
   'travel' and 'shoot' with their needed values.
   The current mouse position for 'targ', the
   boolean value for 'travel', and the coordinates
   of the end of the barrel for 'shoot'.
   
   Also contains functionality for the start and level change
   screens.
   */
  if (!start) { // controls start screen button
    if ((mouseX >= width/3 && mouseX <= (width/3)+buttonWidth) &&
      (mouseY >= height/2 && mouseY <= (height/2)+buttonHeight)) {
      start = true;
      if (!start_played) {
        start_game.play();
        start_played = true;
      }
    }
  } else {
    if (level_screen) { // controls level screen button
      if ((mouseX >= width/3 && mouseX <= (width/3)+buttonWidth) &&
        (mouseY >= height/2 && mouseY <= (height/2)+buttonHeight)) {
        level_screen = false;
      }
    } else {  // If the game is in play.
      if (mouseY <= (barrel_y1 + barrel_len.y)) { // Can't shoot below cannon.
        if (ammo > 0) {  // need ammo to shoot.

          targX = append(targX, mouseX);   // store current mouse position as target
          targY = append(targY, mouseY);

          travel = append(travel, 1);  // shot is now travelling
          shoot_explode = append(shoot_explode, 0);  // shot is not exploding
          shoot_blow_up = append(shoot_blow_up, 3);

          shootX = append(shootX, barrel_x1 + barrel_len.x);   // start at end of barrel
          shootY = append(shootY, barrel_y1 + barrel_len.y);
          ammo --;
          shoot.play();
        }
      }
    }
  }
}


boolean allZeroF(float[] array) {
  /*
    Algorithm to check if all elements in array are zero.
   
   Key Arguments = float[] array
   
   Set a local variable to 0, and if all elements in the array,
   are not equal to the variable, return false.
   Otherwise, return true.
   */
  float value = 0;
  for (int i = 0; i < array.length; i++) {
    if (value != array[i]) {
      return false;
    }
  }
  return true;
}


boolean allZeroI(int[] array) {
  /*
    Same as above, but for int arrays.
   */
  int value = 0;
  for (int i = 0; i < array.length; i++) {
    if (value != array[i]) {
      return false;
    }
  }
  return true;
}
