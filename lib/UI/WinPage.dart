
import 'package:flutter/material.dart';
import 'package:sudoku/Logic/RoutsForPage.dart';

import '../Statics/ColorsForUI.dart';

class WinPage extends StatefulWidget {
  const WinPage({super.key});
  @override
  State<WinPage> createState() => _WinPageState();
}

class _WinPageState extends State<WinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

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
                child: Image.asset('assets/name5.png', fit: BoxFit.cover)
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 120),
            child: const Center(
              child: Column(
                children: [
                  Text('You Win',style: TextStyle( color: Colors.yellow, fontSize: 60),),
                ],
              ),
            ),
          ),
        ],
      ),


      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {RoutsForPages.toHome(context);},
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}
