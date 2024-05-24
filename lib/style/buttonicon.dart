import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
class buttons extends StatelessWidget {
  const buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // عند الضغط على الزر "عرض"
        // _viewPdf(context); // استدعاء دالة عرض الملف PDF مع تمرير السياق
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo.shade500,
              Colors.blue.shade300,
              Colors.indigo.shade800,
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book,
              color:icons.iconsapp,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              'عرض',
              style: fontwhite.fonttitle,
            ),
          ],
        ),
      ),
    );
  }
}
class buttoncancle extends StatelessWidget {
  const buttoncancle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: () {
                
        Navigator.of(context).pop();
      
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade500,
                    Colors.red.shade400,
                    Colors.red.shade900,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                
                  SizedBox(width: 8),
                  Text(
                    'الغاء',
                    style: fontwhite.fonttitle,
                  ),
                ],
              ),
            ),
          );
  }
}
