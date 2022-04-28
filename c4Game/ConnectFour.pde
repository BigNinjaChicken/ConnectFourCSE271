class ConnectFour {
  Cell[][] cells;

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
}
