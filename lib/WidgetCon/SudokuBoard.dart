import 'package:flutter/material.dart';
import 'package:sudoku/Statics/ColorsForUI.dart';
import 'package:sudoku/Statics/StaticThings.dart';

import '../Logic/SudokuCard.dart';

class SudokuBoard extends StatefulWidget {
  final int? type;
  final SudokuCard sudokuCard;
  const SudokuBoard({Key? key,required this.sudokuCard, this.type}) : super(key: key);
  @override
  _SudokuBoardState createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {


  void _selectCell(int row, int column) {
    setState(() {
      StaticThings.selectedRow = row;
      StaticThings.selectedColumn = column;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Column(
        children: [
          for (int i = 0; i < 9; i++)
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                children: [
                  for (int j = 0; j < 9; j++)
                    Flexible(
                      fit: FlexFit.loose,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.type == 1) {
                            i == StaticThings.selectedRow &&
                                j == StaticThings.selectedColumn
                                ? _selectCell(-1, -1)
                                : _selectCell(i, j);
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: i % 3 == 0 ? Colors.black : Colors.black12,
                                width: i % 3 == 0 ? 2.0 : 1.0,
                              ),
                              left: BorderSide(
                                color: j % 3 == 0 ? Colors.black : Colors.black12,
                                width: j % 3 == 0 ? 2.0 : 1.0,
                              ),
                              right: BorderSide(
                                color: (j + 1) % 3 == 0
                                    ? Colors.black
                                    : Colors.black12,
                                width: (j + 1) % 3 == 0 ? 2.0 : 1.0,
                              ),
                              bottom: BorderSide(
                                color: (i + 1) % 3 == 0
                                    ? Colors.black
                                    : Colors.black12,
                                width: (i + 1) % 3 == 0 ? 2.0 : 1.0,
                              ),
                            ),
                            color: StaticThings.selectedRow == i &&
                                StaticThings.selectedColumn == j
                                ? ColorsForUI().backgroundColorSelectedSqr
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.sudokuCard.sudokuBoard[i][j] != 0
                                ? widget.sudokuCard.sudokuBoard[i][j].toString()
                                : '',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}