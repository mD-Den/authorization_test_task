import 'package:authorization_test_task/data/constants/constants.dart';
import 'package:flutter/material.dart';

class PicturePage extends StatelessWidget {
  const PicturePage({Key? key, required this.isSuccessfulEntry})
      : super(key: key);

  final bool isSuccessfulEntry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(isSuccessfulEntry ? happyImage : sadImage),
      ),
    );
  }
}
