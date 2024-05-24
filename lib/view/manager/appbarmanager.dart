import 'package:flutter/material.dart';
import 'package:abeermdrsty/style/fontstyle.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';

class appbarmanager extends StatelessWidget implements PreferredSizeWidget {


  const appbarmanager({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
        "مدرستي",
          textAlign: TextAlign.center,
          style: fontappbar.fonttitle,
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade500,
                Colors.blue.shade300,
                Colors.indigo.shade800,
              ],
            ),
          ),
        ),
      
      
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
