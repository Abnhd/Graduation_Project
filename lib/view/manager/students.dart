import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';

import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/constant/searchbar.dart';

class Student {
  final String name;
  final double grade;

  Student({required this.name, required this.grade});
}

// قم بتعريف بيانات الطلاب هنا
List<Student> students = [
  Student(name: 'عبير 1', grade: 90),
  Student(name: 'طالب 2', grade: 85),
  Student(name: 'طالب 3', grade: 70),
  Student(name: 'طالب 4', grade: 95),
  Student(name: 'طالب 5', grade: 80),
  Student(name: 'طالب 6', grade: 75),
];

class StudentResultsPage extends StatefulWidget {
  final String className; 

  const StudentResultsPage({Key? key, required this.className}) : super(key: key);
  @override
  _StudentResultsPageState createState() => _StudentResultsPageState();
}

class _StudentResultsPageState extends State<StudentResultsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Student> searchResults = [];
  bool _noResults = false;
  String _selectedClass = ''; 
  late Future<List<Student>> _futureStudents; // إضافة متغير لاستيعاب مستقبل البيانات

  @override
  void initState() {
    super.initState();
    // تعيين المستقبل لاستدعاء البيانات
    _futureStudents = fetchStudents();
      searchResults = List<Student>.from(students);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: widget.className.isNotEmpty ? widget.className : "مدرستي"),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SearchBar(
                  controller: _searchController,
                  onChanged: _filterNames,
                  noResults: _noResults,
                ),
                FutureBuilder<List<Student>>(
                  future: _futureStudents, // استخدام المستقبل هنا
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
                    } else if (snapshot.hasData) {
                      // تحديث البيانات المحلية
                      searchResults = snapshot.data!;
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade900,
                              Colors.blue.shade700,
                              Colors.blue.shade700,
                              Colors.blue.shade900
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _noResults ? 0 : searchResults.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          searchResults[index].name,
                                          style: fontstyle.fontheading,
                                        ),
                                        Text(
                                          '${searchResults[index].grade}',
                                          style: fonttitlestyle.fonttitle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("لا توجد نتائج"));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _filterNames(String query) {
    // تنفيذ البحث
    searchResults = students.where((student) => student.name.contains(query)).toList();

    // تحديث قيمة _noResults بناءً على النتائج
    setState(() {
      _noResults = searchResults.isEmpty;
    });
  }

  // دالة لاسترداد بيانات الطلاب كمستقبل
  Future<List<Student>> fetchStudents() async {
    return Future.delayed(Duration(seconds: 2), () => students);
  }
}
