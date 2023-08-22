import 'package:flutter/material.dart';
import 'package:sudoku/BackCon/BackConnection.dart';
import 'package:sudoku/Logic/RoutsForPage.dart';
import 'package:sudoku/Statics/ColorsForUI.dart';
import 'package:sudoku/Statics/StaticThings.dart';
import 'package:sudoku/WidgetCon/CustomToast.dart';
import 'package:sudoku/WidgetCon/PopUps.dart';

import '../Logic/SudokuCard.dart';
import '../WidgetCon/SudokuBoard.dart';

class CardUI extends StatefulWidget {

  final SudokuCard sudokuCard;
  final int index;
  final Function(bool) onCardChanged;

  const CardUI({Key? key, required this.sudokuCard, required this.index, required this.onCardChanged}) : super(key: key);

  @override
  State<CardUI> createState() => _CardUIState();
}

class _CardUIState extends State<CardUI> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorBasedOnType(widget.sudokuCard.type),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  color: Colors.white,
                  child: SudokuBoard(sudokuCard: widget.sudokuCard),
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                          Icons.horizontal_rule,
                          color:Colors.black,
                      ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.horizontal_rule,
                      color:Colors.black,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.horizontal_rule,
                      color:Colors.black,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.horizontal_rule,
                      color:Colors.black,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.horizontal_rule,
                      color:Colors.black,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.horizontal_rule,
                      color:Colors.black,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.horizontal_rule,
                      color:Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
                child: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.sudokuCard.type,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${widget.sudokuCard.percent}%',
                            style: TextStyle(
                              color: ColorsForUI().userPanelColor,
                              fontSize: 30,
                            ),
                          ),
                          Text(widget.sudokuCard.timer,
                            style: TextStyle(
                              color: ColorsForUI().userPanelColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              StaticThings.currentGameInd = widget.index;
                              RoutsForPages.toGame(context, widget.sudokuCard);
                            },
                          ),

                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              bool deleteConfirmed = await PopUps.showDeleteDialog(context);
                              if (deleteConfirmed) {
                                CardInfo().removeCard(CardInfo.sudokuCardList.indexOf(widget.sudokuCard));
                                BackConnection().deleteSudoku(widget.sudokuCard.id, StaticThings.userAccessToken!);
                                CustomToast.showToast('Game was deleted');
                                widget.onCardChanged(true);
                              }
                              
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ),

          ],
        ),
      ),
    );
  }

  Color _getColorBasedOnType(String type) {
    switch (type) {
      case 'EASY':
        return Colors.green;
      case 'NORMAL':
        return Colors.yellow;
      case 'HARD':
        return Colors.red;
      default:
        return Colors.white;
    }
  }
}
