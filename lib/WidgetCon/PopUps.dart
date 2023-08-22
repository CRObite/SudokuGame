

import 'package:flutter/material.dart';
import 'package:sudoku/BackCon/BackConnection.dart';
import 'package:sudoku/Logic/SudokuCard.dart';

import '../Logic/RoutsForPage.dart';
import '../Statics/ColorsForUI.dart';
import '../Statics/StaticThings.dart';
import 'CustomUserRound.dart';

class PopUps{
  static Future<bool> showEndgameDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsForUI().userPanelColor,
          title: const Text('End game',style: TextStyle(color: Colors.white),),
          content: const Text('Are you sure you want to end this game?',style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('End Game'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Return false if value is null
  }

  static Future<bool> showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsForUI().userPanelColor,
          title: const Text('Delete game',style: TextStyle(color: Colors.white),),
          content: const Text('Are you sure you want to delete this game?',style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Return false if value is null
  }
  static Future<bool> showUserProfile(BuildContext context) {

    void updateImage(bool changed) {
      Navigator.of(context).pop(true);
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsForUI().userPanelColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  CustomUserRound(type: 1, onImageChanged: updateImage),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.lightGreen,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      width: 20,
                      height: 20,
                      child: const Center(
                        child: Icon(Icons.edit,color: Colors.white,size: 10,),
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username: ${StaticThings.userName}',style: const TextStyle(color: Colors.white)),
              Text('Game started: ${CardInfo.sudokuCardList.length}',style: const TextStyle(color: Colors.white)),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                BackConnection().logOut(context);
              },
              child: const Text('Log out',style: TextStyle(color: Colors.yellow)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Close',style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  static void showGameStart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsForUI().userPanelColor,
          title: const Text('Select Difficulty',style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDifficultyButton(context, 'EASY', Colors.green),
              const SizedBox(height: 10),
              _buildDifficultyButton(context, 'NORMAL', Colors.yellow),
              const SizedBox(height: 10),
              _buildDifficultyButton(context, 'HARD', Colors.red),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}


Widget _buildDifficultyButton(BuildContext context, String text, Color color) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () async {
        List<List<List<int>>> lists = await BackConnection().getSudoku(text,StaticThings.userAccessToken!);
        SudokuCard newGameData = SudokuCard(StaticThings.sudokuIndex!,0,text,'00:00',lists[0],lists[1]);
        CardInfo().addNewCard(newGameData);
        StaticThings.currentGameInd = CardInfo.sudokuCardList.length-1;
        RoutsForPages.toGame(context, newGameData);
      },
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(text),
    ),
  );
}