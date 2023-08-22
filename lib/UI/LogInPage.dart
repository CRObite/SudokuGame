import 'package:flutter/material.dart';
import 'package:sudoku/Statics/StaticThings.dart';
import 'package:sudoku/WidgetCon/CustomTextFields.dart';
import '../BackCon/BackConnection.dart';
import '../Logic/RoutsForPage.dart';
import '../Statics/ColorsForUI.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMassagePassword;
  String? errorMassageUserName;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsForUI().backgroundColor1,
                  ColorsForUI().backgroundColor2,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Opacity(
              opacity: 0.4,
              child: Image.asset('assets/name1.png', fit: BoxFit.cover)
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Log in',
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

                  CustomTextField(controller: _userController,
                      title: 'Email', suffix: false),
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
                    height: 20,
                  ),

                  GestureDetector(
                    onTap: (){RoutsForPages.toRegister(context);},
                    child: const Text('Register first',
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
                    onPressed: () async {
                      if (checkAllParam()) {

                        await BackConnection().loginUser(_userController.text,
                            _passwordController.text,
                            context);
                        await BackConnection().getUserImage(StaticThings.userAccessToken!);
                        await BackConnection().getAllSudoku(StaticThings.userAccessToken!);
                        RoutsForPages.toHome(context);
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    
  }

  bool checkAllParam(){
    errorMassageUserName = null;
    errorMassagePassword = null;

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
    }
    return true;
  }
}