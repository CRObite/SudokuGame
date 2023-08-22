
import 'package:flutter/material.dart';
import 'package:sudoku/Logic/RoutsForPage.dart';
import 'package:sudoku/WidgetCon/CustomToast.dart';

import '../BackCon/BackConnection.dart';
import '../Statics/ColorsForUI.dart';
import '../WidgetCon/CustomTextFields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMassageEmail;
  String? errorMassageUserName;
  String? errorMassagePassword;
  String? errorMassagePassword2;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsForUI().backgroundColor3,
                  ColorsForUI().backgroundColor4,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

          ),
          Opacity(
              opacity: 0.4,
              child: Image.asset('assets/name2.png', fit: BoxFit.cover)
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    CustomTextField(controller: _emailController,
                        title: 'Email', suffix: false),
                    const SizedBox(
                      height: 10,
                    ),
                    if(errorMassageEmail!= null)
                      Text(
                        errorMassageEmail!,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(controller: _userController,
                        title: 'User name', suffix: false),
                    const SizedBox(
                      height: 10,
                    ),
                    if(errorMassageUserName!= null)
                      Text(
                        errorMassageUserName!,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(controller: _passwordController,
                        title: 'Password', suffix: true),
                    const SizedBox(
                      height: 10,
                    ),
                    if(errorMassagePassword!= null)
                      Text(
                        errorMassagePassword!,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(controller: _password2Controller,
                        title: 'Retype password', suffix: true
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(errorMassagePassword2!= null)
                      Text(
                        errorMassagePassword2!,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),

                    GestureDetector(
                      onTap: (){RoutsForPages.toLogin(context);},
                      child: const Text('Login if you already have account',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ColorsForUI().backgroundButton,
                        fixedSize: Size(MediaQuery.of(context).size.width-160, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: (){
                          if (checkAllParam()) {
                            BackConnection().registerUser(_emailController.text,_userController.text,
                                _passwordController.text, _password2Controller.text,
                                context);
                            CustomToast.showToast("You have successfully registered");
                          }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),



        ],
      ),
    );

  }

  bool checkAllParam(){
    errorMassageEmail = null;
    errorMassageUserName = null;
    errorMassagePassword = null;
    errorMassagePassword2 = null;

    if (_emailController.text.isEmpty) {
      setState(() {
        errorMassageEmail = "Please enter your email";
      });
      return false;

    } else if (!BackConnection().isValidEmail(_emailController.text)) {
      setState(() {
        errorMassageEmail = "Invalid email format";
      });
      return false;
    }

    if (_userController.text.isEmpty) {
      setState(() {
        errorMassageUserName = "Please enter your user name";
      });
      return false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        errorMassagePassword = "Please enter your password";
      });
      return false;

    } else if (_passwordController.text.length < 6) {
      setState(() {
        errorMassagePassword = "Password must be at least 6 characters";
      });
      return false;
    }

    if (_password2Controller.text.isEmpty) {
      setState(() {
        errorMassagePassword2 = "Please retype your password";
      });
      return false;
    } else if (_password2Controller.text != _passwordController.text) {
      setState(() {
        errorMassagePassword2 = "Passwords do not match";
      });
      return false;
    }

    return true;
  }


}





