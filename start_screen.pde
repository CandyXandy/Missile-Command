// START BUTTON
int buttonWidth = 80; // also used in level_change tab.
int buttonHeight = 50;

// LOGIC
boolean start = false;  // Flag for showing the start screen, shows on false.


void start_screen() {
  /*
  Displays a start screen at the beginning of the game.
   
   Calls window_rect, then displays a button and some text.
   Asks for user input, clicking the button will start the game.
   Based on the examples given in Lecture 3
   */
  window_rect(); // refer below. 
   
  if ((mouseX >= width/3 && mouseX <= (width/3)+buttonWidth) &&
    (mouseY >= height/2 && mouseY <= (height/2)+buttonHeight)) {
    // change button color based on mouse position.
    fill(0, 200, 0);
  } else {
    fill(200, 0, 0);
  }
  rect(width/3, height/2, buttonWidth, buttonHeight); // button
  
  // Button text
  fill(255);
  textSize(16);
  textAlign(CENTER);
  text("Start Game", (width/2) + 5, (height/2)+30);
  
  // Top text
  fill(255);
  textSize(24);
  textAlign(CENTER);
  text("MISSILE COMMAND", (width/2), 30);
  textSize(16);
  text("Defend your cities!", (width/2), 60);
  text("Missiles = 1 score, Grenades = 2 score.", (width/2), 80);
  text("At the end of each level, you will receive 3 score for each remaining building half.",
  (width/2), 100);
  text("You will also receive 1 score for each ammo you have remaining.", (width/2), 120);
  text("Will you survive all 3 levels?", (width/2), 140);
  text("Good luck Commander!", (width/2), 160);
}


void window_rect() {
  /**
    Simple function to display rectangle that encompasses entire screen.
    
    Used in the start screen, game over screen, game ended screen, and
    the level screen. Stops game elements from coming through to those
    particular screens.
  */
  if (!start || end_game || game_over || level_screen) {
    fill(0);
    rect(0, 0, width, height);
  }
}
