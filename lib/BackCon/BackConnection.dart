import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/Logic/RoutsForPage.dart';
import 'package:sudoku/WidgetCon/CustomToast.dart';
import '../Logic/SudokuCard.dart';
import '../Statics/StaticThings.dart';

class BackConnection{



  Future<void> registerUser(String email,String username, String password, String confirmPass, BuildContext context) async {

    try {
      final dio = Dio();
      final response = await dio.post(
        '${StaticThings.ipAddress}${StaticThings.registerEndpoint}',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPass,
        },
      );

      if (response.statusCode == 200){
        print('Response: ${response.data}');
        RoutsForPages.toLogin(context);

      } else {
        print('Error: ${response.statusCode}');
        CustomToast.showToast( "Such a user already exists or incorrect data has been entered");

      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast("Server issues, we'll fix it soon");
    }
  }

  Future<void> loginUser(String username, String password, BuildContext context) async {

    try {
      final dio = Dio();
      final response = await dio.post(
        '${StaticThings.ipAddress}${StaticThings.authenticateEndpoint}',
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        print('Response: ${response.data}');

        StaticThings.userName = response.data['username'];
        StaticThings.userAccessToken = response.data['token'];
      } else {
        print('Error: ${response.statusCode}');
        CustomToast.showToast( "Invalid data entered or such user does not exist in the database");
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast("Server issues, we'll fix it soon");
    }
  }

  Future<void> setSudoku(List<List<int>> sudokuBoard,List<List<int>> sudokuFullBoard,String timer, String jwtToken) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      final response = await dio.put(
        '${StaticThings.ipAddress}${StaticThings.setSudokuEndpoint}${StaticThings.sudokuIndex}',
        data: {
          'id': StaticThings.sudokuIndex,
          'solution': convertTo1DArray(sudokuFullBoard),
          'puzzle': convertTo1DArray(sudokuBoard),
          'difficulty': 3.0,
          'timer': convertString(timer),
        },
      );
      if (response.statusCode == 200) {
        print('Response: ${response.data}');
      } else {
        print('Error: ${response.statusCode}');
        CustomToast.showToast( "Invalid data entered or such user does not exist in the database");
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast("Server issues, we'll fix it soon");
    }
  }

  bool isValidEmail(String email) {

    const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    return RegExp(emailRegex).hasMatch(email);
  }

  Future<void> logOut(BuildContext context) async {
    StaticThings.userAccessToken = null;
    StaticThings.userName = null;
    RoutsForPages.toLogin(context);
  }

  Future<void> deleteSudoku(int sudokuId, String jwtToken) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      final response = await dio.delete(
          '${StaticThings.ipAddress}${StaticThings.deleteSudokuEndpoint}$sudokuId');
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Error: ${response.statusCode}');
        CustomToast.showToast("XFGXBS");
      }
    } catch (e) {
      print('Error: $e');
      CustomToast.showToast("Server issues, we'll fix it soon");
    }
  }

  Future<void> uploadImageWithToken(File imageFile, String jwtToken) async {
    try {
      Dio dio = Dio();

      dio.options.headers['Authorization'] = 'Bearer $jwtToken';

      // Create a FormData object to send the image file
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      Response response = await dio.post(
        '${StaticThings.ipAddress}${StaticThings.uploadImageEndpoint}',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> updateSudokuValue(int gameId,int row,int col,int value, String jwtToken) async {
    try {
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';

      Response response = await dio.post(
        '${StaticThings.ipAddress}${StaticThings.uploadImageEndpoint}',
        data: {
          'gameId': gameId,
          'row': row,
          'col': col,
          'newValue': value,
        },
      );
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }



  Future<List<List<List<int>>>> getSudoku(String level, String jwtToken) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      final response = await dio.get(
        '${StaticThings.ipAddress}${StaticThings.sudokuEndpoint}$level',
      );

      if (response.statusCode == 200) {
        print(response.data);

        print(response.data['solution'].runtimeType);

        StaticThings.sudokuIndex = response.data['id'];
        final data = response.data as Map<String, dynamic>;
        final solution = data['solution'] as List<dynamic>;
        final puzzle = data['puzzle'] as List<dynamic>;

        List<List<int>> sudokuFullBoard = List.generate(9, (_) => List.generate(9, (_) => 0));
        List<List<int>> sudokuBoard = List.generate(9, (_) => List.generate(9, (_) => 0));

        for (int i = 0; i < 9; i++) {
          for (int j = 0; j < 9; j++) {
            sudokuFullBoard[i][j] = solution[i * 9 + j] as int;
            sudokuBoard[i][j] = puzzle[i * 9 + j] as int;
          }
        }
        return[sudokuBoard,sudokuFullBoard];
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
    }

    return[];
  }

  Future<void> getUserImage(String jwtToken) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      final response = await dio.get(
        '${StaticThings.ipAddress}${StaticThings.getImageEndpoint}',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        print('Response: ${response}');
        Uint8List imageBytes = response.data as Uint8List;
        File jpegFile = byteArrayToFile(imageBytes);
        StaticThings.userIcon = jpegFile;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getUserID(String jwtToken) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      final response = await dio.get(
        '${StaticThings.ipAddress}${StaticThings.getIDEndpoint}',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        StaticThings.userID = response.data['id'];
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getAllSudoku(String jwtToken) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $jwtToken';
      final response = await dio.get(
        '${StaticThings.ipAddress}${StaticThings.sudokuAllEndpoint}',
      );
      if (response.statusCode == 200) {
        print(response.data);
        List<dynamic> puzzles = response.data;



        for (var puzzle in puzzles) {

          final solutionTrue = puzzle['solution'] as List<dynamic>;
          final puzzleTrue = puzzle['puzzle'] as List<dynamic>;

          List<List<int>> sudokuFullBoard = List.generate(9, (_) => List.generate(9, (_) => 0));
          List<List<int>> sudokuBoard = List.generate(9, (_) => List.generate(9, (_) => 0));

          for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
              sudokuFullBoard[i][j] = solutionTrue[i * 9 + j] as int;
              sudokuBoard[i][j] = puzzleTrue[i * 9 + j] as int;
            }
          }

          CardInfo().addNewCard(SudokuCard(puzzle['id'],calcPercent(sudokuBoard), puzzle['difficulty'], minutesToTimeString(puzzle['timer']), sudokuBoard, sudokuFullBoard));
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

int calcPercent(List<List<int>> board){
  int count = 0;

  for (var row in board) {
    count += row.where((number) => number != 0).length;
  }

  return count;
}


File byteArrayToFile(Uint8List bytes) {
  String tempPath = Directory.systemTemp.path;
  File file = File('$tempPath/temp.jpg');
  file.writeAsBytesSync(bytes);
  return file;
}

int convertString(String tim){
  List<String> parts = tim.split(':');
  return int.parse(parts[0]) * 60 + int.parse(parts[1]);
}

String minutesToTimeString(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;

  String hoursString = hours.toString().padLeft(2, '0');
  String minutesString = minutes.toString().padLeft(2, '0');

  return '$hoursString:$minutesString';
}

List<int> convertTo1DArray(List<List<int>> nestedList) {
  List<int> flattenedList = [];

  for (var row in nestedList) {
    flattenedList.addAll(row);
  }
  print(flattenedList);
  return flattenedList;
}