import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';

class Gradst extends StatefulWidget {
  @override
  _GradstState createState() => _GradstState();
}

class _GradstState extends State<Gradst> {
  int _selectedOption = 0; // الخيار المحدد الافتراضي

  List<String> options = [
    'االشهر الاول',
    'الشهر الثاني',
    ' النهائي الاول',
    'الشهر الاول',
    'الشهر الثتاني',
    'النهائي الثاني',
  ];

  // قائمة المواد والدرجات
  List<Map<String, dynamic>> subjectsAndGrades = [
    {"subject": "Math", "grade": 90},
    {"subject": "Science", "grade": 85},
    {"subject": "History", "grade": 78},
    {"subject": "English", "grade": 92},
    {"subject": "Art", "grade": 88},
    {"subject": "Geography", "grade": 75},
    {"subject": "Physics", "grade": 80},
  ];

  @override
  Widget build(BuildContext context) {
    return  Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "مدرسي",),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*.60,
                child: Card(
                  elevation: 5,
                shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                  child: DropdownButton(
                    isExpanded: true, // لجعل القائمة تمتد عبر العرض
                    value: _selectedOption,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOption = newValue as int;
                      });
                    },
                    items: options.map((option) {
                      return DropdownMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: fonttitlestyle.fonttitle,
                            ),
                          
                          ],
                        ),
                        value: options.indexOf(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: subjectsAndGrades.length, 
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            subjectsAndGrades[index]['subject'],
                            style:fonttitlestyle.fonttitle,
                          ), 
                          trailing: Text(
                            '${subjectsAndGrades[index]['grade']}',
                            style: fonttitlestyle.fonttitle,
                          ),
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
    );
  }
}
