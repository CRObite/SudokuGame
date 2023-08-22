
import 'package:flutter/cupertino.dart';

import 'SudokuCard.dart';

class RoutsForPages{

  static void toHome(BuildContext context ) =>{Navigator.pushReplacementNamed(context, '/home')};
  static void toRegister(BuildContext context ) =>{Navigator.pushReplacementNamed(context, '/register')};
  static void toLogin(BuildContext context ) =>{Navigator.pushReplacementNamed(context, '/')};
  static void toWin(BuildContext context) =>{Navigator.pushReplacementNamed(context, '/win')};
  static void toGame(BuildContext context , SudokuCard card) =>{Navigator.pushReplacementNamed(context, '/game', arguments: card)};
}