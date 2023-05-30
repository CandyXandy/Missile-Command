// LOGIC
boolean level_screen; // Flag for showing level change screen.

// COLOR
color green = color(0,255,0);

void level_change() {
  /*
    Sets up for level change.
   
   When it's time to change levels, this function
   sets up the game environment to allow for a
   'reset' of variables. If the 4th level is
   reached, the game is ended.
   
   The setup() function can be called, as each objects's
   setup() function (e.g. shoot_setup() ) has been
   carefully crafted to allow this.
   */
  if (allZeroF(boolean_bomb)) {
    // If all standard bombs in a level have been destroyed or exploded.
    
    calc_score(ammo);  // give score for buildings and ammo remaining
    calc_build_score(top_building);
    calc_build_score(bottom_building);

    level_difficulty ++;  // increment level difficulty
    
    if (level_difficulty == 4) { // if you reach level 4 ..
      end_game = true; // the game is ended!
      
    } else {
      setup(); // resets variables needed for level change
      level_played = false;  // making sure the jingle will play.
      level_screen = true;
    }
  }
}


void level_screen() {
  /*
  Displays a new level screen.
   
   This function shows the new level screen,
   asking for the user to click the start
   button before continuing onto the next
   level.
   Calls window_rect() and then displays a button and
   some text.
   Based on example from Lecture 3.
   Borrows 'buttonWidth' and 'buttonHeight'
   from start_screen().
   */
   
  window_rect();  // Refer to start_screen tab.
  
  if (!level_played) {
    start_level.play();
    level_played = true;
  }
  if ((mouseX >= width/3 && mouseX <= (width/3)+buttonWidth) &&
    (mouseY >= height/2 && mouseY <= (height/2)+buttonHeight)) {
      // Displays a different colour upon mouse over.
    fill(green);
  } else {
    fill(red);
  }
  // button
  rect(width/3, height/2, buttonWidth, buttonHeight);
  
  // text
  fill(255);
  textSize(16);
  textAlign(CENTER);
  text("Start Level: " + level_difficulty, (width/2) + 5, (height/2)+30);
  text("Score: " + score, (width/2) + 5, (height/2)+60);
}
