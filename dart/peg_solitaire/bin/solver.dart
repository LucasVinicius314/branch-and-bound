const X = true;
const O = false;
const _ = null;

class Solver {
  // final List<List<bool?>> board = [
  //   [_, _, X, X, X, _, _],
  //   [_, _, X, X, X, _, _],
  //   [X, X, X, X, X, X, X],
  //   [X, X, X, O, X, X, X],
  //   [X, X, X, X, X, X, X],
  //   [_, _, X, X, X, _, _],
  //   [_, _, X, X, X, _, _],
  // ];

  final List<List<bool?>> board = [
    [_, _, O, O, O, _, _],
    [_, _, O, X, X, _, _],
    [O, O, X, O, X, O, O],
    [O, O, O, X, X, O, O],
    [O, O, O, O, X, O, O],
    [_, _, O, X, X, _, _],
    [_, _, O, O, X, _, _],
  ];

  // final List<List<bool?>> board = [
  //   [_, _, O, O, O, _, _],
  //   [_, _, O, X, X, _, _],
  //   [O, O, X, O, O, O, O],
  //   [O, O, O, X, O, O, O],
  //   [O, O, O, O, X, O, O],
  //   [_, _, O, X, O, _, _],
  //   [_, _, O, O, O, _, _],
  // ];

  int getCount() {
    var count = 0;

    for (var row in board) {
      for (var column in row) {
        if (column == true) {
          count++;
        }
      }
    }

    return count;
  }

  @override
  String toString() {
    return board.map((e) {
      return e.map((e) {
        return {
          true: 'X',
          false: 'O',
          null: '_',
        }[e];
      }).join(' ');
    }).join('\n');
  }
}
