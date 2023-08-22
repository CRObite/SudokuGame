
import 'package:flutter/material.dart';
import 'package:sudoku/BackCon/BackConnection.dart';
import 'package:sudoku/Logic/RoutsForPage.dart';
import 'package:sudoku/Statics/StaticThings.dart';
import 'package:sudoku/WidgetCon/CustomNumberButton.dart';
import 'package:sudoku/WidgetCon/CustomUserRound.dart';
import 'package:sudoku/WidgetCon/SudokuBoard.dart';

import '../Logic/SudokuCard.dart';
import '../Statics/ColorsForUI.dart';
import '../WidgetCon/CustomToast.dart';
import '../WidgetCon/PopUps.dart';
import '../WidgetCon/Timer.dart';

class GamePage extends StatefulWidget {

  final SudokuCard sudokuCard;
  const GamePage({Key? key, required this.sudokuCard}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late Widget _sudokuBoardContent;
  late int _hits;
  @override
  void initState() {
    _sudokuBoardContent = SudokuBoard(sudokuCard: widget.sudokuCard, type: 1);
    _hits = countMatches(widget.sudokuCard.sudokuBoard, widget.sudokuCard.sudokuFullBoard);
    super.initState();
  }

  @override
  void dispose() {
    final newPercent = ((calcPercent(widget.sudokuCard.sudokuBoard) / 81) * 100).round();
    widget.sudokuCard.percent = newPercent;
    BackConnection().setSudoku(widget.sudokuCard.sudokuBoard, widget.sudokuCard.sudokuFullBoard, widget.sudokuCard.timer, StaticThings.userAccessToken!);
    super.dispose();
  }

  void _handleImageChanged(bool isFavorite) {
    setState(() {
    });
  }

  void _handleNumberTap(int pickedNumber) {

    if(StaticThings.selectedRow != -1 && StaticThings.selectedColumn != -1){
      widget.sudokuCard.sudokuBoard[StaticThings.selectedRow][StaticThings.selectedColumn] = pickedNumber;
      StaticThings.selectedRow = -1;
      StaticThings.selectedColumn = -1;
    }
    setState(() {
      _sudokuBoardContent = SudokuBoard(sudokuCard: widget.sudokuCard, type: 1);
      _hits = countMatches(widget.sudokuCard.sudokuBoard, widget.sudokuCard.sudokuFullBoard);
    });

    if(calcPercent(widget.sudokuCard.sudokuBoard)==81 && countMatches(widget.sudokuCard.sudokuBoard, widget.sudokuCard.sudokuFullBoard)==81){
      CardInfo().removeCard(CardInfo.sudokuCardList.indexOf(widget.sudokuCard));
      RoutsForPages.toWin(context);
      BackConnection().deleteSudoku(widget.sudokuCard.id, StaticThings.userAccessToken!);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width-40,
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomUserRound(type: 2,onImageChanged: _handleImageChanged,),
                    Text(widget.sudokuCard.type, style: TextStyle(color: ColorsForUI().userPanelColor,fontSize: 24),),
                    GestureDetector(
                      onTap: () async {
                        bool endGameConfirmed = await PopUps.showEndgameDialog(context);
                        if (endGameConfirmed) {
                          RoutsForPages.toHome(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorsForUI().userPanelColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Text('×',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsForUI().backgroundColor7,
                  ColorsForUI().backgroundColor8,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
                opacity: 0.4,
                child: Image.asset('assets/name4.png', fit: BoxFit.cover)
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorsForUI().backgroundButton,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hit Raid: $_hits',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),

                TimerText(gameTime: widget.sudokuCard.timer),
              ],
            ),
          ),

          Center(
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _sudokuBoardContent,
              ),
            ),
          ),
        ],
      ),


      bottomNavigationBar: Container(
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomNumberButton(text: 1, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 2, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 3, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 4, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 5, onNumberTap: _handleNumberTap),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomNumberButton(text: 6, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 7, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 8, onNumberTap: _handleNumberTap),
                const SizedBox(width: 20),
                CustomNumberButton(text: 9, onNumberTap: _handleNumberTap),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

int calcPercent(List<List<int>> board){
  int count = 0;

  for (var row in board) {
    count += row.where((number) => number != 0).length;
  }

  return count;
}

int countMatches(List<List<int>> unsolved,List<List<int>> solved) {
  int matchCount = 0;
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (unsolved[row][col] == solved[row][col]) {
        matchCount++;
      }
    }
  }
  return matchCount;
}