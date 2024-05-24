import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/custom_drawer.dart';

class book extends StatefulWidget {
  const book({ Key? key }) : super(key: key);

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: CustomAppBar(title: 'الكتاب'),
              endDrawer: CustomDrawer(),
    );
  }
}