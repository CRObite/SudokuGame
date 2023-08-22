
import 'package:flutter/material.dart';

import 'SudokuBoard.dart';

class CustomNumberButton extends StatefulWidget {
  final int text;
  final Function(int) onNumberTap;
  const CustomNumberButton({Key? key, required this.text, required this.onNumberTap}) : super(key: key);

  @override
  State<CustomNumberButton> createState() => _CustomNumberButtonState();
}

class _CustomNumberButtonState extends State<CustomNumberButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onNumberTap(widget.text);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text('${widget.text}', style: const TextStyle(color: Colors.grey, fontSize: 18),),
        ),
      ),
    );

  }
}
