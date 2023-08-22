
import 'package:sudoku/Statics/StaticThings.dart';

class SudokuCard {
  int _id;
  int _percent;
  String _type;
  String _timer;
  List<List<int>> _sudokuBoard;
  List<List<int>> _sudokuFullBoard;

  SudokuCard(this._id,this._percent, this._type, this._timer, this._sudokuBoard, this._sudokuFullBoard);

  int get percent => _percent;

  set percent(int newValue) {
    if (newValue >= 0 && newValue <= 100) {
      _percent = newValue;
    } else {
      throw ArgumentError("Percentage must be between 0 and 100");
    }
  }


  int get id => _id;

  set id(int newValue) {
    _id = newValue;
  }

  String get type => _type;

  set type(String newValue) {
    _type = newValue;
  }

  String get timer => _timer;

  set timer(String newValue) {
    _timer = newValue;
  }

  List<List<int>> get sudokuBoard => _sudokuBoard;

  set sudokuBoard(List<List<int>> newValue) {
    _sudokuBoard = newValue;
  }

  List<List<int>> get sudokuFullBoard => _sudokuFullBoard;

  set sudokuFullBoard(List<List<int>> newValue) {
    _sudokuFullBoard = newValue;
  }

}


class CardInfo{
  static List<SudokuCard> sudokuCardList = [];

  List<SudokuCard> get getCards => sudokuCardList;

  set setCards(List<SudokuCard> list){
    sudokuCardList = list;
  }

  addNewCard(SudokuCard newCard) => sudokuCardList.add(newCard);
  removeCard(int index)=> sudokuCardList.removeAt(index);
}
