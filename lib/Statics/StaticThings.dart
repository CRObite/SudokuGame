
import 'dart:io';

class StaticThings{

  static String host = 'http://';
  static String ipAddress = '${host}192.168.1.126:8080';
  static String registerEndpoint = '/api/auth/signup';
  static String authenticateEndpoint = '/api/auth/signin';
  static String getIDEndpoint = '/api/user/currentUserId';
  static String getImageEndpoint = '/api/image/profileImage';
  static String uploadImageEndpoint = '/api/image/upload';
  static String logOutEndpoint = '/logout';
  static String sudokuEndpoint = '/api/game/generate?difficulty=';
  static String sudokuAllEndpoint = '/api/game/user';
  static String setSudokuEndpoint = '/api/game/';
  static String deleteSudokuEndpoint = '/api/game/delete/';
  static String setSudokuTimerEndpoint = '/api/game/timer';



  static int? userID;
  static String? userName;
  static String? userAccessToken;
  static File? userIcon;
  static int? sudokuIndex;

  static List<List<int>> sudokuBoard = List.generate(9, (_) => List.generate(9, (_) => 0));
  static List<List<int>> sudokuFullBoard = List.generate(9, (_) => List.generate(9, (_) => 0));
  static int selectedRow = -1;
  static int selectedColumn = -1;

  static int? currentGameInd;
}