import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';



import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/view/student/comment.dart';
import 'package:abeermdrsty/view/student/notes.dart';
import 'package:abeermdrsty/view/student/viewnotification.dart';
import 'package:abeermdrsty/view/student/viewnotivication2.dart';
import 'package:abeermdrsty/view/teacher/tabbar/test.dart';

import 'grade.dart';

class Myclass extends StatelessWidget {
  // List of gradient colors for even cards
  List<List<Color>> evenCardGradients = [
    [Colors.blue.shade900, Colors.blue.shade700],
    [Colors.blue.shade700, Colors.blue.shade900],
  ];

  // List of gradient colors for odd cards
  List<List<Color>> oddCardGradients = [
    [Colors.blue.shade800, Colors.blue.shade600],
    [Colors.blue.shade600, Colors.blue.shade800],
  ];

  // Map linking each card index to its respective page
  final Map<int, Widget> pageRoutes = {
    0: NotesPage(),
    1: Gradst(),
    2:notificationmanager(),
    3: CommentPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "مدرستي"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 95, horizontal: 45),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.shade400,
                Colors.blue.shade400,
                Colors.indigo.shade800,
              ],
            ),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: clases.length,
              itemBuilder: (BuildContext context, int index) {
                List<Color> gradientColors = index.isEven
                    ? evenCardGradients[index ~/ 2]
                    : oddCardGradients[index ~/ 2];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      // Navigate to the respective page when card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pageRoutes[index]!),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height *.12,
                      child: Center(
                        child: Text(
                          clases[index].title,
                          style: fontwhite.fonttitle
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Example pages

