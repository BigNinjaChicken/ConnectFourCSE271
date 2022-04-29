class ConnectFour {
  Cell[][] cells;
  int player = 1; // keeps track of which players turn it is.
  int moveCount = 0; // helps keep track of when the game is ending in a tie.
  boolean inProgress = true; // helps keep track of when the game is over.

  ConnectFour(int rows, int cols) {
    if (rows < 4 || cols < 4) {
      throw new IllegalArgumentException("rows, cols must be >= 4");
    }
    cells = new Cell[rows][cols];

    // This would probably be better in a helper method.
    for (int row = 0; row < cells.length; row++) {
      for (int cell = 0; cell < cells[0].length; cell++) {
        cells[row][cell] = new Cell();
      }
    }
  }

  // Sets a cell to player 1, 2, or empty (0)
  void updateCell(int row, int col, int player) {
    cells[row][col].setPlayer(player);
    display();
  }

  // Displays all the cells, by calling each cell's display() method.
  void display() {
    for (int row = 0; row < cells.length; row++) {
      for (int cell = 0; cell < cells[0].length; cell++) {
        cells[row][cell].display(cell * CELL_WIDTH, row * CELL_WIDTH);
      }
    }
  }

  // Returns the number of rows in the game
  int getRows() {
    return cells.length;
  }

  // Returns the number of columns in the game
  int getCols() {
    return cells[0].length;
  }

  // These methods print useful information to the console
  void printRow(int row) {
    for (int i = 0; i < cells[row].length; i++) {
      print(cells[row][i].getPlayer() + " ");
    }
    println();
  }

  void printColumn(int col) {
    for (int i = 0; i < cells.length; i++) {
      println(cells[i][col].getPlayer());
    }
  }

  void printGrid() {
    for (int row = 0; row < cells.length; row++) {
      printRow(row);
    }
  }

  void showPlayerMarker(int col) {
    if (cells[0][col].getPlayerMarker() == 0) {
      resetMarkers();
      
      if (player == 1) {
        cells[0][col].setPlayerMarker(1);
      } else if (player == 2) {
        cells[0][col].setPlayerMarker(2);
      }

      display();
    }
  }
  
  void resetMarkers() {
    for (int i = 0; i < cells[0].length; i++) cells[0][i].setPlayerMarker(0);
  }

  // makes a move in the specified column (but not if that column is full).
  void makeMove(int col) {
    if (inProgress) {
      if (cells[0][col].getPlayer() > 0) {
        System.out.println("column " + (col + 1) + " is full");
        return;
      }

      for (int row = cells.length - 1; row >= 0; row--) {
        if (cells[row][col].getPlayer() == 0) {

          updateCell(row, col, player);
          
          System.out.println("player " + player + " at " + (row + 1) + " " + (col + 1));

          if ((checkHorizontalWin(row, col, 1) + checkHorizontalWin(row, col, -1) - 1) >= 4) {
            winHorizontal(row, col, 1);
            winHorizontal(row, col, -1);

            chooseWinner();
            return;
          } else if ((checkVerticalWin(row, col)) >= 4) {
            winVertical(row, col);

            chooseWinner();
            return;
          } else if ((checkDiagonalTop(row, col, 1) + checkDiagonalBottom(row, col, -1) - 1) >= 4) {
            winDiagonalTop(row, col, 1);
            winDiagonalBottom(row, col, -1);

            chooseWinner();
            return;
          } else if ((checkDiagonalBottom(row, col, 1) + checkDiagonalTop(row, col, -1) - 1) >= 4) {
            winDiagonalBottom(row, col, 1);
            winDiagonalTop(row, col, -1);

            chooseWinner();
            return;
          }

          moveCount++;
          if (ROWS * COLS == moveCount) tieGame();

          resetMarkers();
          swapPlayer();
          return;
        }
      }
    }
  }

  // tell user its a tie game
  void tieGame() {
    System.out.println("TIE GAME!!");
    inProgress = false;
    
    System.out.println("GAME IS OVER!");
  }

  // say the winner of the game
  void chooseWinner() {
    System.out.println("PLAYER " + player + " WINS!!");
    inProgress = false;
    display();
    
    System.out.println("GAME IS OVER!");
  }

  // Horizontal Methods
  int checkHorizontalWin(int row, int col, int dir) {
    if (col > cells[row].length - 1 || col < 0 || cells[row][col].getPlayer() != player) return 0;

    return 1 + checkHorizontalWin(row, col + dir, dir);
  }

  int winHorizontal(int row, int col, int dir) {
    if (col > cells[row].length - 1 || col < 0 || cells[row][col].getPlayer() != player) return 0;

    cells[row][col].setIsHighlighted(true);
    return 1 + winHorizontal(row, col + dir, dir);
  }

  // Vertical Methods
  int checkVerticalWin(int row, int col) {
    if (row > cells.length - 1 || row < 0 || cells[row][col].getPlayer() != player) return 0;

    return 1 + checkVerticalWin(row + 1, col);
  }

  int winVertical(int row, int col) {
    if (row > cells.length - 1 || row < 0 || cells[row][col].getPlayer() != player) return 0;

    cells[row][col].setIsHighlighted(true);
    return 1 + winVertical(row + 1, col);
  }
  
  // Diagonal Top Methods
  int checkDiagonalTop(int row, int col, int dir) {
    if (row > cells.length - 1 || row < 0 || col > cells[row].length - 1 || col < 0 || cells[row][col].getPlayer() != player) return 0;

    return 1 + checkDiagonalTop(row + 1, col + dir, dir);
  }

  int winDiagonalTop(int row, int col, int dir) {
    if (row > cells.length - 1 || row < 0 || col > cells[row].length - 1 || col < 0 || cells[row][col].getPlayer() != player) return 0;

    cells[row][col].setIsHighlighted(true);
    return 1 + checkDiagonalTop(row + 1, col + dir, dir);
  }
  
  // Diagonal Bottom Methods
  int checkDiagonalBottom(int row, int col, int dir) {
    if (row > cells.length - 1 || row < 0 || col > cells[row].length - 1 || col < 0 || cells[row][col].getPlayer() != player) return 0;

    return 1 + checkDiagonalBottom(row - 1, col + dir, dir);
  }

  int winDiagonalBottom(int row, int col, int dir) {
    if (row > cells.length - 1 || row < 0 || col > cells[row].length - 1 || col < 0 || cells[row][col].getPlayer() != player) return 0;

    cells[row][col].setIsHighlighted(true);
    return 1 + checkDiagonalBottom(row - 1, col + dir, dir);
  }

  // swaps the players between 1 and 2
  void swapPlayer() {
    if (player == 1) {
      player = 2;
    } else if (player == 2) {
      player = 1;
    }
  }

  // Resets the Game
  void initializeGame() {
    for (int row = 0; row < cells.length; row++) {
      for (int cell = 0; cell < cells[0].length; cell++) {
        cells[row][cell].setIsHighlighted(false);
        cells[row][cell].setPlayerMarker(0);
        cells[row][cell].setPlayer(0);
      }
    }
    
    player = 1;
    moveCount = 0;
    
    display();
    
    inProgress = true; // Keep at bottom
  }
}
