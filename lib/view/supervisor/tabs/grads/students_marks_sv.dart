import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/constant/buttoncolor.dart';
import 'package:abeermdrsty/view/supervisor/component/drawer/custom_drawer.dart';


class StudentMarks_SV extends StatefulWidget {
  @override
  _StudentMarks_SVState createState() => _StudentMarks_SVState();
}

class _StudentMarks_SVState extends State<StudentMarks_SV> {
  late Future<List<Student>> futureStudents;
  TextEditingController searchController = TextEditingController();
  late List<Student> originalStudents;
  List<Student> filteredStudents = [];
  bool showNoResults = false;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  Future<List<Student>> fetchStudents() async {
    final response = await http.get(
        Uri.parse('https://my.api.mockaroo.com/students_marks?key=7bf0ba50'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Student> students =
          jsonData.map((e) => Student.fromJson(e)).toList();
      setState(() {
        originalStudents = students;
        filteredStudents = List.from(originalStudents);
      });
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: 'درجات الطلاب',),
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    elevation: 9,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          filteredStudents = List.from(originalStudents);
                          showNoResults = false;
                        } else {
                          filteredStudents = originalStudents
                              .where((student) =>
                                  student.firstName
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  student.lastName
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();
                          showNoResults = filteredStudents.isEmpty;
                        }
                      });
                    },
                    decoration: InputDecoration(
                                hintText: 'ابحث...',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (showNoResults)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('لاتوجد نتائج'),
                  ),
                Expanded(
                  child: FutureBuilder<List<Student>>(
                    future: futureStudents,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: filteredStudents.length,
                          itemBuilder: (context, index) {
                            final student = filteredStudents[index];

                            return Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Displaying the student's name
                                    Center(
                                      child: Text(
                                        '${student.firstName} ${student.lastName}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 16), // Adding some spacing

                                    // Row for Month 1 exam mark
                                    Row(
                                      children: [
                                        Text(
                                          'الشهر الاول:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            width: 10), // Adding some spacing
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'ادخل درجة الشهر الاول',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8), // Adding some spacing

                                    // Row for Month 2 exam mark
                                    Row(
                                      children: [
                                        Text(
                                          'الشهر الثاني:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            width: 10), // Adding some spacing
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'ادخل درجة الشهر الثاني',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8), // Adding some spacing

                                    // Row for Final Exam mark
                                    Row(
                                      children: [
                                        Text(
                                          'الاختبار الفصلي:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            width: 10), // Adding some spacing
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'ادخل درجة الاختبار الفصلي',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('لاتوجد بيانات'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: CustomGradientButton(
                buttonText: 'حفظ',
                hasHomework: true,
                onPressed: () {
                  // Add your save logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  late int id;
  late String firstName;
  late String lastName;
  late double month1;
  late double month2;
  late double finalExam;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.month1,
    required this.month2,
    required this.finalExam,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      month1: json['month1'],
      month2: json['month2'],
      finalExam: json['final'],
    );
  }
}
