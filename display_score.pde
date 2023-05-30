// LOGIC
int score = 0;  // running tally of score.

// STRING
String S_score = "Score: "; // used in end_game and level_change also.

// LOCATION
int score_box_X = 0;
int score_box_Y = 0;

// DIMENSIONS
int score_box_W = 120;
int score_box_H = 60;

// COLOUR
color white = color(255);


int calc_score(int s) {
  /**
    Simple function for adding score.
  */
  score += s;
  return score;
}


int calc_build_score(int[] array) {
  /**
    Calculate the score given by buildings.
    
    Iterates over every value in an array,
    and gives 3 score for every building's half
    you have left.
  */
  int value = 0;
  for (int elem : array) { // for each element in array
    value += (elem * 3);  // increment value
  }
  score += value;
  return value;
}


void display_score() {
  /*
    Displays the score on the screen.
    
    Shows a border and some text.
  */
  noFill();
  stroke(white);
  rect(score_box_X, score_box_Y, score_box_W, score_box_H);
  
  fill(green);
  textSize(16);
  text(S_score + score, score_box_X + 5, score_box_Y + 5,
  score_box_W, score_box_H - 20);
}
