// COLLISION DIMS
int smart_leeway = 10;  
// provides more forgiving collision for smart boms.


void collision() {
  /**
   Calculates collision between ABM and Bombs and gives score for them.
   
   Uses distance colission. Each bomb hit gives one score, controlled by
   score_given, and each smart bomb gives two score, controlled by
   smart_score_given.
   */
  for (int i = 0; i < shootX.length; i++) {
    for (int j = 0; j < bomb_x.length; j++) {
      if ((dist(shootX[i], shootY[i], bomb_x[j], bomb_y[j]) <= building_width)
      && shoot_explode[i] != 0) {
        
        boolean_bomb[j] = 0;
        
        if (score_given[j] != 1) { // Ensure missiles only give 1 score.
          calc_score(1);
          score_given[j] = 1;
        }
      }
    }
  }
  for ( int j = 0; j < shootX.length; j++) {
    for ( int i = 0; i < smart_x.length; i++) {
      if ((dist(shootX[j], shootY[j], smart_x[i], smart_y[i]) <= building_width)
      && shoot_explode[j] != 0) {
        
        smart_bomb_active[i] = 0;
        
        if (smart_score_given[i] == 0) {
          calc_score(2);  // smart bombs give 2 score.
          smart_score_given[i] = 1;
        }
      }
    }
  }
}


void collision_city() {
  /**
   calculates collision between Bombs and buildings and removes buildings from play.
   
   The if statements are huge, and so are explained here:
   For a smart bomb or bomb to hit a building, they obviously must come close,
   and the corresponding building must exist (building_bottom, building_top).
   The bomb must also be active.
   
   Once the collision is detected, the necessary variables are set to remove the
   bomb and building from play and the bombs respective explode function is called.
   The soundfile is also played here to prevent audio glitches.
   */

  for (int i = 0; i < buildings_top_x.length; i++) {
    for (int j = 0; j < bomb_x.length; j++) {
      if ((bomb_x[j] > (buildings_top_x[i] - building_width) &&
        bomb_x[j] < (buildings_top_x[i] + building_width)) &&
        (bomb_y[j] > (buildings_top_y[i] - building_height) &&
        bomb_y[j] < (buildings_top_y[i] + building_height)) &&
        top_building[i] == 1 && boolean_bomb[j] == 1) {
          
        boolean_bomb[j] = 0;  // bomb no longer active
        boolean_explode[j] = 1;  // bomb exploding
        
        bomb_explode();
        explosion.play();  // playing here prevents audio glitches.
        
        top_building[i] = 0;  // stop displaying building level.
      }
    }
  }
  for (int i = 0; i < buildings_bottom_x.length; i++) {
    for (int j = 0; j < bomb_x.length; j++) {
      if ((bomb_x[j] > (buildings_bottom_x[i] - 50) &&
        bomb_x[j] < (buildings_bottom_x[i] + 50)) &&
        (bomb_y[j] > (buildings_bottom_y[i] - 50) &&
        bomb_y[j] < (buildings_bottom_y[i] + 55)) &&
        top_building[i] == 0 && boolean_bomb[j] == 1 &&
        bottom_building[i] == 1) {
          
        boolean_bomb[j] = 0;
        boolean_explode[j] = 1;
        bomb_explode();
        explosion.play();
        
        bottom_building[i] = 0;
      }
    }
  }
}


void collision_city_smart() {
  /**
   Controls collision between smart bombs and buildings.
   
     Another giant if statement, the building and the smart bomb must be close
     to eachother, but nowhere near as strict as the standard missiles.
     This is because the smart bombs generate a large explosion which can remove
     many buildings at once. Top or bottom building must be active, depending
     on which collision is detected. The smart bomb must also be active.
     
   Smart_bombs destroy 2 buildings. If they hit the top half of a building, the
   bottom half is also removed. If the bottom is hit first, the function checks
   to see if there are any buildings to the left, and if there is, takes half
   a building from there. If not, it checks to the right, following the same
   procedure.
   */
  for (int i = 0; i < buildings_bottom_x.length; i++) {
    for (int j = 0; j < smart_x.length; j++) {
      if ((smart_x[j] >= (buildings_bottom_x[i] - building_width) &&
        smart_x[j] <= (buildings_bottom_x[i] + building_width)) &&
        ((smart_y[j] + smart_leeway) >= (buildings_bottom_y[i] - smart_leeway) &&
        (smart_y[j] - smart_leeway) <= (buildings_bottom_y[i] + smart_leeway)) &&
        top_building[i] == 0 && smart_bomb_active[j] == 1 && bottom_building[i] == 1) {
          
        smart_bomb_active[j] = 0;  // smart bomb no longer active
        smart_bomb_exploding[j] = 1;  // smart bomb exploding
        smart_bomb_explosion.play();
        
        bottom_building[i] = 0;
        
        if (i != 0) {  // is there anything to the left?
          if (top_building[i-1] == 1) {  // smart_bombs destroy 2 building halves.
            top_building[i-1] = 0;  // can we destroy left?
          
          } else if (bottom_building[i-1] == 1) {  // if not, can we destroy bottom left?
            bottom_building[i-1] = 0;
          }
          
        } else if (i != top_building.length - 1) { // if not, is there anything to right?
          if ( top_building[i+1] == 1) { // can we destroy right top?
            top_building[i+1] = 0;
            
          } else if (top_building[i+1] == 0 && // if not, can we destroy bottom right?
            bottom_building[i+1] == 1) {
            bottom_building[i+1] = 0;
          }
        }
      }
    }
  }
  for (int i = 0; i < buildings_top_x.length; i++) {
    for ( int j = 0; j < smart_x.length; j++) {
      if ((smart_x[j] >= (buildings_top_x[i] - building_width) &&
        smart_x[j] <= (buildings_top_x[i] + building_width)) &&
        (smart_y[j]>= (buildings_top_y[i] - smart_leeway) &&
        (smart_y[j] - smart_leeway) <= (buildings_top_y[i] + smart_leeway)) &&
        top_building[i] == 1 && smart_bomb_active[j] == 1) {
          
        smart_bomb_active[j] = 0;
        smart_bomb_exploding[j] = 1;
        smart_bomb_explosion.play();
        
        top_building[i] = 0; // if smart bomb hits top half..
        bottom_building[i] = 0;  // destroy bottom too
      }
    }
  }
}
