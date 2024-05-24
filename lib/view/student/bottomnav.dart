import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/view/student/myclass.dart';
import 'package:abeermdrsty/view/student/profile.dart';
import 'package:abeermdrsty/view/student/tabletime.dart';
import 'package:abeermdrsty/view/student/terms.dart';
import 'package:abeermdrsty/view/student/viewlibry.dart';
import 'package:abeermdrsty/view/student/viewnotivication2.dart';



class TabStudent extends StatefulWidget {
  @override
  _TabStudentState createState() => _TabStudentState();
}

class _TabStudentState extends State<TabStudent> {
  int _currentIndex = 0;

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TabStudent()),
            );
            return false;
          },
          child: Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: [
              TermPage(),
                ClassSchedule(),
                Myclass(),
              notificationmanager(),
              LibraryPage(),
                Profilestudent(),
              ],
            ),
            bottomNavigationBar: Container(
            
              height: displayWidth * .16,
              decoration: BoxDecoration(
              
            
                  gradient: LinearGradient(
                  
                                        colors: [
                                              Colors.blue.shade900, Colors.blue.shade700,
                                              Colors.blue.shade700, Colors.blue.shade900
                                             ],
                                             ),
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  listOfIcons.length,
                  (index) => GestureDetector(
                    onTap: () {
                      _onTabChange(index);
                      HapticFeedback.lightImpact();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          listOfIcons[index],
                          color: _currentIndex == index
                              ? Colors.black
                              : Colors.white,
                          size: 28,
                        ),
                        SizedBox(height: 5),
                        Text(
                          listOfStrings[index],
                          style: TextStyle(
                            color: _currentIndex == index
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.menu_book,
    Icons.schedule_outlined,
    Icons.assignment,
    Icons.notifications,
    Icons.my_library_books,
    Icons.person,
  ];

  List<String> listOfStrings = [
    'المواد',
    'جدولي',
    'فصلي',
    'الإشعارات',
    'المكتبة',
    'حسابي',
  ];
}
