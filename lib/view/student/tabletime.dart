import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/style/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';

class ClassSchedule extends StatefulWidget {
  @override
  _ClassScheduleState createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  int _currentDayIndex = 0; // يمثل اليوم الأول (الأحد) كافتراضيًا

  final List<Map<String, String>> schedule = [
    {"day": "الأحد", "الحصة الاولى": "عربي", "الحصة الثانية": "عربي", "الحصة الثالثة": "عربي"},
    {"day": "الاثنين", "الحصة الاولى": "عربي", "الحصة الثانية": "عربي", "الحصة الثالثة": "عربي"},
    {"day": "الثلاثا","الحصة الاولى": "عربي", "الحصة الثانية": "عربي", "الحصة الثالثة": "عربي"},
    {"day": "الاربعاء", "الحصة الاولى": "ل"},
    {"day": "الخميس", "الحصة الاولى": "ب"},
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "مدرستي",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_currentDayIndex > 0) {
                                _currentDayIndex--;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.blue.shade900,
                        ),
                        Text(
                          schedule[_currentDayIndex]["day"]!,
                          style: fontstyle.fontheading,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_currentDayIndex < schedule.length - 1) {
                                _currentDayIndex++;
                              }
                            });
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                          color: Colors.blue.shade900,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: schedule[_currentDayIndex].length - 1, // يحسب عدد الحصص
                      itemBuilder: (context, index) {
                        final session = schedule[_currentDayIndex].keys.elementAt(index + 1);
                        final subject = schedule[_currentDayIndex][session];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              subject!,
                              style: fonttitlestyle.fonttitle,
                            ),
                            trailing: Text(
                              session,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
