import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fragment extends StatelessWidget {
  final String title;

  const Fragment(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
       //   fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
