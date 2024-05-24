import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';

import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';

import 'drawer/custom_drawer.dart';

class NotesParent extends StatefulWidget {
  const NotesParent({Key? key}) : super(key: key);

  @override
  _NotesParentState createState() => _NotesParentState();
}

class _NotesParentState extends State<NotesParent> {
  late List<DateTime> weekDays;
  late int currentIndex;



  List<Map<String, String>> filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    weekDays = generateWeekDays();
    currentIndex = DateTime.now().weekday - 1;
  }

  List<DateTime> generateWeekDays() {
    DateTime now = DateTime.now();
    int todayIndex = now.weekday;
    List<DateTime> days = [];

    for (int i = 1; i <= 7; i++) {
      days.add(now.subtract(Duration(days: todayIndex - i)));
    }

    return days;
  }

  void moveToNextDay() {
    if (currentIndex < 6) {
      setState(() {
        currentIndex++;
      });
    }
  }

  void moveToPreviousDay() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: appbarchild(title: "التقييم"),
        drawer: Drawerparent(),
      
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          
              height: MediaQuery.of(context).size.height * .74,
                decoration: BoxDecoration(
                            gradient: LinearGradient(
            colors: [
            Colors.blue.shade900, Colors.blue.shade700,
                                            Colors.blue.shade700, Colors.blue.shade900
            ],
          ),
                            shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(10))
                            
                          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: moveToNextDay,
                      icon: Icon(Icons.arrow_back_ios,
                      color: Colors.white,),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM yyyy', 'ar').format(weekDays[currentIndex]),
                      style: fontwhite.fonttitle
                    ),
                    IconButton(
                      onPressed: moveToPreviousDay,
                      icon: Icon(Icons.arrow_forward_ios,
                      color: Colors.white,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                    final subject = subjects[index];
                final subjectName = subject['name']!;
                final lessonName = subject['lesson']!;
                return SubjectListItem(
                  subjectName: subjectName,
                  lessonName: lessonName,
                );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SubjectListItem extends StatefulWidget {
  final String subjectName;
  final String lessonName;

  SubjectListItem({
    required this.subjectName,
    required this.lessonName,
  });

  @override
  _SubjectListItemState createState() => _SubjectListItemState();
}

class _SubjectListItemState extends State<SubjectListItem> {
  bool isCardHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCardHighlighted = !isCardHighlighted;
          });
        },
        child: Card(
          elevation: 5,
          // color: Colors.indigo[500],
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          
          child: ExpansionTile(
            title: Center(
              child: Text(
                widget.subjectName,
                style:fontstyle.fontheading
              ),
            ),
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.lessonName,
                    style:fonttitlestyle.fonttitle
                  ),
                ),
              ),
            ],
            tilePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            collapsedTextColor: Colors.black,
            collapsedIconColor: Colors.red[900],
            textColor: Colors.indigo[900],
            iconColor: Colors.indigo[900],
          ),
        ),
      ),
    );
  }
}
