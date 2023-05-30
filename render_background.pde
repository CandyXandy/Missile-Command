// BUILDING
  // VISUAL
  PImage building_top;
  PImage building_bottom;
  
  // DIMENSION
  int building_width = 50;  // building dimensions
  int building_height = 55;
  
  // LOGIC
  int [] top_building;  // Controls if buildings are drawn.
  int [] bottom_building;
  
  int setter_bottom; // Helps to place buildings.
  int setter_top;
  
  // LOCATION
  int [] buildings_top_x;
  int [] buildings_top_y;
  int [] buildings_bottom_x;
  int [] buildings_bottom_y;
  
// TERRAIN
  // VISUAL
  PImage tree;
  
  // LOGIC
  int terrain_setter_x;  // helps to place trees.
  int terrain_setter_y;
  
  // LOCATION
  int platform_x;  // location for cannon platform
  int platform_y = 675;
  
  int terrain_x = 0;  // location for terrain planes.
  int terrain_y;
  
  int [] tree_x;  // location of trees.
  int [] tree_y;
  
  // DIMENSION
  int platform_height = 50; // platform dimensions
  int platform_width = 70;
  
  int terrain_width;  // terrain plane dimensions
  int terrain_height;
  
  int tree_dims = 30;  // tree dimensions
  
  // COLOUR
  color terrain_colour1 = #00FF00;
  color terrain_colour2 = #375D2C;
  color terrain_colour3 = #243F4B;

  // BACKGROUND COLOUR
  color bg_colour1 = 0;
  color bg_colour2 = #2D5C5F;
  color bg_colour3 = #474D25;


void setup_buildings() {
  /**
    Initialises variables required for setting up buildings.
    
    Also loads some images.
    Each building is given their place guided by the
    'setter_**' variables.
  */
  top_building = new int[6];
  bottom_building = new int[6];
  
  buildings_top_x = new int[6];
  buildings_top_y = new int[6];
  
  buildings_bottom_y = new int[6];
  buildings_bottom_x = new int[6];
  
  building_top = loadImage("castle_top.png");
  building_bottom = loadImage("castle_bottom.png");
  
  setter_bottom = 100;
  setter_top = 100;
  
  for (int i = 0; i < buildings_bottom_x.length - 2; i++) {
    // first 3 building bottoms.
    buildings_bottom_x[i] = setter_bottom;
    buildings_bottom_y[i] = height - 100;
    setter_bottom += 100;
  }

  for (int i = 3; i < buildings_bottom_x.length; i++) {
    // last 3 building bottoms.
    buildings_bottom_x[i] = setter_bottom;
    buildings_bottom_y[i] = height - 100;
    setter_bottom += 100;
  }

  for (int i = 0; i < buildings_top_x.length - 2; i++) {
    // first 3 building tops.
    buildings_top_x[i] = setter_top;
    buildings_top_y[i] = height - 150;
    setter_top += 100;
  }

  for (int i = 3; i < buildings_top_x.length; i++) {
    // last 3 building tops.
    buildings_top_x[i] = setter_top;
    buildings_top_y[i] = height - 150;
    setter_top += 100;
  }

  for (int i = 0; i < 6; i ++) { 
    top_building[i] = 1;
    bottom_building[i] = 1;
  }
}


void setup_terrain() {
  /**
    Initialises variables for terrain.
  */
  platform_x = width/2;  // needs to be called in .. 
  terrain_y = height - 100;  // .. setup to pick up screen width.
  
  terrain_width = width;
  terrain_height = 100;
}


void setup_trees() {
  /**
    Initialises variables for placing trees.
    
    Also loads the tree image.
    Trees are placed along the terrain, and are given
    a random y value (between 0 and 20) minus height.
  */
  tree_x = new int[6];
  tree_y = new int[6];
   
  tree = loadImage("tree.png");
  
  terrain_setter_x = 0;
  terrain_setter_y = height - 50;
  
  for (int i = 0; i < tree_x.length; i++) {
    terrain_setter_y += random(20);
    
    tree_x[i] = terrain_setter_x + 100;
    tree_y[i] = terrain_setter_y;
    
    terrain_setter_x += 120;
    terrain_setter_y -= random(20); // subtraction to decrease offset between tree_y's.
  }
}


void draw_buildings() {
  /**
    Draws the buildings to the game environemnt.
  */
  for (int i = 0; i < buildings_bottom_x.length; i++) {
    if (bottom_building[i] != 0) {
      image(building_bottom, buildings_bottom_x[i], buildings_bottom_y[i],
      building_width, building_height);
    }
  }

  for (int i = 0; i < buildings_top_x.length; i++) {
    if (top_building[i] != 0) {
      image(building_top, buildings_top_x[i], buildings_top_y[i],
      building_width, building_height);
    }
  }
}


void draw_terrain() {
  /**
    Draws the bottom terrain to the game environment.
    
    Chooses a colour for the plane that the buildings
    sit on based on the level number.
    Also displays a platform for the cannon.
  */
  
  // Primary terrain.
  if (level_difficulty == 1) {
    fill(terrain_colour1);
  } else if (level_difficulty == 2 ) {
    fill(terrain_colour2);
  } else if (level_difficulty == 3 ) {
    fill(terrain_colour3);
  }
  noStroke();
  rect(terrain_x, terrain_y, terrain_width, terrain_height);
          
  // Platform for cannon.
  noStroke();
  rectMode(CENTER);
  rect(platform_x, platform_y, platform_width, platform_height);
  rectMode(CORNER);  // Sets back to corner as every other rectangle uses CORNER mode.
}


void draw_trees() {
  /**
    Displays trees on the terrain.
  */
  for (int i = 0; i < tree_x.length; i++) {
    image(tree, tree_x[i], tree_y[i], tree_dims, tree_dims);
  }
}
