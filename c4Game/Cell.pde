//Cell class, one Cell is a single location on a connect 4 board and has a x y location, 
//a player associated with it (default is 0) 
class Cell {
  color PLAYER_1_COLOR = color(255, 0, 0);
  color PLAYER_2_COLOR = color(0);
  color BACK_COLOR = color(100);

  int player;
  
  boolean isHighlighted = false;
  int playerMarker = 0;

  // Constructs an initially empty cell
  Cell() {
    this.player = 0;
  }

  // Sets the cell to the win highlighted
  void setIsHighlighted(boolean highlighted) {
    isHighlighted = highlighted;
  }
  
  // Sets the player turn indication
  void setPlayerMarker(int player) {
     playerMarker = player; 
  }
  
  // Returns the player turn indication
  int getPlayerMarker() {
     return playerMarker; 
  }

  // Sets the player for a particular cell
  void setPlayer(int player) {
    this.player = player;
  }
  
  // Returns who the player is: 1, 2, or empty (0)
  int getPlayer() {
    return player;
  }

  // Determines how a cell should be displayed
  void display(float x, float y) {
    stroke(0);
    strokeWeight(1);

    // yellow square
    fill(200, 200, 0);
    square(x, y, CELL_WIDTH);
    
    // Highlighted
    if (isHighlighted) {
      fill(200, 100, 40);
      square(x, y, CELL_WIDTH);
    }
    
    // Player Marker
    if (playerMarker == 1) {
      fill(200, 0, 0);
      circle(x + CELL_WIDTH/2, y + CELL_WIDTH/2, CELL_WIDTH * 1);
    } else if (playerMarker == 2) {
      fill(0, 0, 0);
      circle(x + CELL_WIDTH/2, y + CELL_WIDTH/2, CELL_WIDTH * 1);
    }
    
    // circle based on which player is in the cell
    if (player == 0) {
      fill(BACK_COLOR);
    } else if (player == 1) {
      fill(PLAYER_1_COLOR);
    } else {
      fill(PLAYER_2_COLOR);
    }
    noStroke();
    circle(x + CELL_WIDTH/2, y + CELL_WIDTH/2, CELL_WIDTH * 0.9);
  }
}//end Cell class
