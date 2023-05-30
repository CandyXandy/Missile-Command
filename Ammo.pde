// TOTAL AMMO
int ammo;

// AMMO STRING
String ammo_S = "Ammo: ";

// AMMO DISPLAY LOCATION
int ammo_x;
int ammo_y;


void setup_ammo() {
  /**
   Initialise variables for ammo.
   */
  ammo = 15;
  ammo = ammo + (level_difficulty * 5);
  ammo_x = 0;
  ammo_x = constrain(ammo_x, (width / 2) - 10, (width / 2) + 20);
  ammo_y = height - 95;
}

void display_ammo() {
  /**
    Displays ammo under score.
   */
  fill(green);
  textSize(16);
  text(ammo_S + ammo, score_box_X + 5, score_box_Y + 25,
  score_box_W, score_box_H - 30);
}
