import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:abeermdrsty/constant/class.dart';
import 'package:abeermdrsty/view/teacher/attendteacher.dart';
import 'package:abeermdrsty/view/teacher/tabbar/mnotification/mnotification.dart';
import 'package:abeermdrsty/view/supervisor/tabs/addnotivication.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/homeworknotification/Homework_tab.dart';
import 'package:abeermdrsty/view/teacher/tabbar/profile/profile.dart';
import 'package:abeermdrsty/view/teacher/tabbar/schadule/schadule.dart';


class tabsbutton extends StatefulWidget {
  @override
  _tabsbuttonState createState() => _tabsbuttonState();
}

class _tabsbuttonState extends State<tabsbutton> {
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
        textDirection: TextDirection.ltr,
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => tabsbutton()),
            );
            return false;
          },
          child: Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: [
                Profileteacher(),
                WeeklySchedule(),
                attendteacher(),
                teacherclass(),
                notificationsuper(),
                notification(),
                

              
              ],
            ),
            bottomNavigationBar: Container(
              height: displayWidth * .16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade700,
                    Colors.blue.shade700,
                    Colors.blue.shade900
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
    Icons.person,
    Icons.schedule,
    Icons.check_box,
    Icons.class__outlined,
    Icons.home_max,
    Icons.notifications_active,
    
  ];

  List<String> listOfStrings = [
    'حسابي',
    'جدولي',
    'الحضور',
    'الفصول',
    'فصلي',
    'الاشعارات',
    
  ];
}
