import 'package:flutter/material.dart';

class GlobalStyle {
  static TextStyle primaryTextButtonColor(BuildContext context) {
    return TextStyle(color: Theme.of(context).colorScheme.primary);
  }

  static TextStyle whiteTextButtonColor() {
    return const TextStyle(color: Colors.white);
  }

  static Container buildGradientTopToBottom() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black45,
              Colors.grey.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              1.0
            ]),
      ),
    );
  }

    static Container buildGradientBottomToTop(double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
            colors: [
              Colors.black45,
              Colors.grey.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              1.0
            ]),
      ),
    );
  }
}
