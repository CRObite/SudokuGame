import 'package:flutter/material.dart';
import 'package:sudoku/BackCon/BackConnection.dart';
import 'package:sudoku/Logic/SudokuCard.dart';
import 'package:sudoku/UI/LogInPage.dart';
import 'UI/GamePage.dart';
import 'UI/HomePage.dart';
import 'UI/RegisterPage.dart';
import 'UI/WinPage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Map<String, WidgetBuilder> routes = {
    '/': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/home': (context) => const HomePage(),
    '/game': (context) {
      final sudokuCard = ModalRoute.of(context)!.settings.arguments as SudokuCard;
      return GamePage(sudokuCard: sudokuCard);
    },
    '/win': (context) => const WinPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}


