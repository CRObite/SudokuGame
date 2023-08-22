
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sudoku/BackCon/BackConnection.dart';
import 'package:sudoku/Logic/PickImage.dart';
import 'package:sudoku/Statics/StaticThings.dart';
import 'package:sudoku/WidgetCon/PopUps.dart';

import '../Statics/ColorsForUI.dart';

class CustomUserRound extends StatefulWidget {
  final int? type;
  final Function(bool)? onImageChanged;
  final Function(bool)? onPopUpsClosed;
  const CustomUserRound({Key? key, this.type, this.onImageChanged, this.onPopUpsClosed }) : super(key: key);

  @override
  State<CustomUserRound> createState() => _CustomUserRoundState();
}

class _CustomUserRoundState extends State<CustomUserRound> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
          if(widget.type==null){
            bool res = await PopUps.showUserProfile(context);
            if(res) {
              widget.onPopUpsClosed!(true);
            }
          }else if(widget.type==1){
            await PickImage().pickImageFromGallery();
            File image = PickImage.image!;
            print(image);
            BackConnection().uploadImageWithToken(image, StaticThings.userAccessToken!);
            StaticThings.userIcon = image;
            widget.onImageChanged!(true);
          }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorsForUI().userPanelColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 60,
        height: 60,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: StaticThings.userIcon == null? Image.asset(
              'assets/profile.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ): Image.file(
              StaticThings.userIcon!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
