import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';

class Reset extends StatelessWidget {
  const Reset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("R E S E T"),
        titleTextStyle: TextStyle(
          fontSize: 30,
        ),
        centerTitle: true,
        backgroundColor: apppurple.withOpacity(.5),
      ),
      body: Center(
        child: Text("Reset"),
      ),
    );
  }
}
