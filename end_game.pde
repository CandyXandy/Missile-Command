//LOGIC
boolean game_over;  // flag for game over.
boolean end_game;  // flag for end of game.

// SOUND
SoundFile game_lost; // played on game over
SoundFile game_won;  // played on end game
SoundFile start_level; // played at start of level.
SoundFile start_game;  // played at game start.

  // SOUND LOGIC
  boolean lost_played; // required so sounds don't play ..
  boolean won_played;  // .. 60 times per seocond.
  boolean level_played;
  boolean start_played;
  
  
  
void setup_sounds() {
  /**
  Sets up some miscallaneous sounds and
  their flags (so they don't play 60 times
  per second) for gameplay.
  */
  lost_played = false;
  won_played = false;
  start_played = false;
  
  game_lost = new SoundFile(this, "game_over.wav");
  game_won = new SoundFile(this, "game_win.wav");
  start_level = new SoundFile(this, "start_level.wav");
  start_game = new SoundFile(this, "start_game.wav");
}


void game_over() {
  /**
    Displays the game over screen.
    
    Calls window_rect() and displays some text.
    Then calls the key_action function to allow restart or quit.
  */  
  if (!lost_played) {
    game_lost.play();
    lost_played = true;
  }
  window_rect();  // Refer to start_screen tab.
  
  textMode(CENTER);
  textSize(16);
  fill(255);
  text( "Game Over!", width/2, height/2);
  text(S_score + score, width/2, height/2 + 20);
  text("Press R to restart or Q to quit", width/2, height/2 + 40);
  
  key_action();
}


void end_game() {
  /**
    Displays the screen that shows when the game is finished.
    
    Calls window_rect() and then displays some text.
    Calls the key_action function to allow to restart or quit.
  */
  window_rect();  // Refer to start_screen tab
  
  if (!won_played) {
    game_won.play();
    won_played = true;
  }
  
  textMode(CENTER);
  textSize(16);
  fill(255);
  text("Congratulations! You beat the game!", width/2, height/2);
  text(S_score + score, width/2, height/2 + 20);
  text("Press R to restart or Q to quit", width/2, height/2 + 40);
  
  key_action();
}


void key_action() {
  /**
    Called by game_over() and end_game(), to allow
    for key presses by the player to quit or restart the game.
  */
  if (game_over || end_game) { // game over or end game must be true
    if (keyCode == 'R') {  // Restart on R
      level_difficulty = 1;  // set level to 1
      setup();  // Refer to level_change tab.
      score = 0;
      start = false;  // show start screen
      
      end_game = false;  // game can't function if these are true..
      game_over = false; // ..
      
    } else if (keyCode == 'Q') {
      exit(); // Quit on Q.
    }
  }
}
