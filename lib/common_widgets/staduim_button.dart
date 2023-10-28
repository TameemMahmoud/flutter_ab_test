import 'package:flutter/material.dart';

import '../utils/resources/app_colors.dart';

class StadiumButton extends StatelessWidget {
  final String title;
  final Function() fct;
  final double? buttonWidth;
  const StadiumButton({Key? key, required this.title, required this.fct, this.buttonWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: buttonWidth,
      child: MaterialButton(
        onPressed: fct,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        color: AppColors.mainColor,
        child: Text(title, style: const TextStyle(color: Colors.white),),
      ),
    );
  }
}
