import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errrorMsg;

  const ErrorText({Key? key, required this.errrorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errrorMsg,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
