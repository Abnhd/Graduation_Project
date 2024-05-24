import 'package:flutter/material.dart';

class textfieldwidget extends StatelessWidget {
  const textfieldwidget({
    Key? key,
    required this.maxline,
    required this.hinttext,
  }) : super(key: key);
  final String hinttext;
  final int maxline;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hinttext,
            
          ),
          maxLines: maxline,
        ));
  }
}
