import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool? suffix;

  final TextEditingController controller;

  const CustomTextField({required this.controller, required this.title, required this.suffix, Key? key})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.suffix == true ?  TextInputType.visiblePassword: TextInputType.emailAddress,
      controller: widget.controller,
      obscureText: widget.suffix == true ? !_passwordVisible: false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.title,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),

        suffixIcon: widget.suffix == true ? IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ): null,
      ),
    );
  }
}
