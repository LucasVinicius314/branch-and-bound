import 'solver.dart';

enum Direction {
  top,
  left,
  right,
  bottom,
}

int calls = 0;

final solver = Solver();

void main(List<String> arguments) {
  solve(solver.getCount(), solver.board.length);

  print('\n======\n');

  print('calls: $calls');
}

int getXOffset(Direction direction) {
  switch (direction) {
    case Direction.top:
      return 0;
    case Direction.left:
      return -1;
    case Direction.right:
      return 1;
    case Direction.bottom:
      return 0;
  }
}

int getYOffset(Direction direction) {
  switch (direction) {
    case Direction.top:
      return 1;
    case Direction.left:
    case Direction.right:
      return 0;
    case Direction.bottom:
      return -1;
  }
}

void solve(int pegs, int width) {
  calls++;

  for (var x = 0; x < width; x++) {
    for (var y = 0; y < width; y++) {
      for (var direction in [
        Direction.top,
        Direction.left,
        Direction.right,
        Direction.bottom
      ]) {
        final xOffset = getXOffset(direction);
        final yOffset = getYOffset(direction);

        final neighbourX = x + xOffset;
        final neighbourY = y + yOffset;

        final farX = x + xOffset * 2;
        final farY = y + yOffset * 2;

        if (farX < 0 || farX > width - 1) {
          continue;
        }

        if (farY < 0 || farY > width - 1) {
          continue;
        }

        // Is a peg.
        if (solver.board[x][y] == true) {
          // Has a neighbour peg.
          if (solver.board[neighbourX][neighbourY] == true) {
            // Has an empty neighbour peg.
            if (solver.board[farX][farY] == false) {
              solver.board[x][y] = false;
              solver.board[neighbourX][neighbourY] = false;
              solver.board[farX][farY] = true;

              if (solver.getCount() == 1) {
                print('$solver\n');
              }

              solve(pegs - 1, width);

              solver.board[x][y] = true;
              solver.board[neighbourX][neighbourY] = true;
              solver.board[farX][farY] = false;
            }
          }
        }
      }
    }
  }
}
