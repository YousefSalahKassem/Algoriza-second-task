import 'package:flutter/material.dart';
import 'package:todoalgoriza/styles/dimensions.dart';

class ButtonApp extends StatelessWidget {
  Color color;
  VoidCallback onPressed;
  String text;

  ButtonApp(
      {Key? key,
      required this.color,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      color: color,
      onPressed: onPressed,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.height30 * 3, vertical: context.height15),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 18,
            ),
          )),
    );
  }
}
