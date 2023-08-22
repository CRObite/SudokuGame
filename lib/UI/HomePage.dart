

import 'package:flutter/material.dart';
import 'package:sudoku/Logic/SudokuCard.dart';
import 'package:sudoku/Statics/StaticThings.dart';
import 'package:sudoku/UI/CardUI.dart';
import 'package:sudoku/WidgetCon/CustomToast.dart';
import 'package:sudoku/WidgetCon/CustomUserRound.dart';
import 'package:sudoku/WidgetCon/PopUps.dart';

import '../BackCon/BackConnection.dart';
import '../Statics/ColorsForUI.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Widget _userRound;
  @override
  void initState() {
    super.initState();
    _userRound = CustomUserRound(onPopUpsClosed: _handleImageChanged);
    _performDelayedUpdate();
  }

  void _performDelayedUpdate() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
    });
  }
  void _handleCardChanged(bool isFavorite) {
    setState(() {
    });
    CustomToast.showToast('Game was Deleted');
  }
  void _handleImageChanged(bool isFavorite) {
    setState(() {
      _userRound = CustomUserRound(onPopUpsClosed: _handleImageChanged);
    });
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
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 40,
                    child: Container(
                      height: 40,
                      width: null,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorsForUI().userPanelColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                          child: Text(
                            StaticThings.userName != null ? StaticThings.userName! : "",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _userRound,
                ],
              ),
            ),
          ],
        )
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsForUI().backgroundColor5,
                  ColorsForUI().backgroundColor6,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Opacity(
              opacity: 0.4,
              child: Image.asset('assets/name3.png', fit: BoxFit.cover)
          ),

          CardInfo().getCards.isEmpty || CardInfo().getCards == null ?
          const Center(
            child: Text(
              'Press New Game',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ):Container(
            margin: const EdgeInsets.only(top: 90, bottom: 50),
            child: ListView.builder(
                itemCount: CardInfo().getCards.length,
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index){
                  return CardUI(sudokuCard: CardInfo.sudokuCardList[index],index: index,onCardChanged: _handleCardChanged);
                }
            ),
          ),


        ],
      ),

      bottomNavigationBar: GestureDetector(
        onTap: (){
          PopUps.showGameStart(context);
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 40.0),
          decoration:  BoxDecoration(
            color: ColorsForUI().userPanelColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),

            child: const Center(
                child: Text('New Game',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
            ),
          ),
      ),
    );
  }
}
