import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/view/student/components/drawer/custom_drawer.dart';

class bookpdf extends StatelessWidget {
  const bookpdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "الكتاب",),
        drawer: CustomDrawer(),
      ),
    );
  }
}
