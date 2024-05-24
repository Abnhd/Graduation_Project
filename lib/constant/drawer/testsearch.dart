// import 'package:collasable_drawer/wedgits/buttoncolor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'dart:convert';

import 'package:abeermdrsty/constant/buttoncolor.dart';


class Homework {
  final String studentName;
  final String studentAvatarUrl;
  final String date;

  Homework({
    required this.studentName,
    required this.studentAvatarUrl,
    required this.date,
  });
}

class ViewHomeworkTabtest extends StatefulWidget {
  @override
  _ViewHomeworkTabtestState createState() => _ViewHomeworkTabtestState();
}

class _ViewHomeworkTabtestState extends State<ViewHomeworkTabtest> {
  late List<Homework> originalHomeworks;
  List<Homework> filteredHomeworks = [];
  late TextEditingController searchController;
  bool showNoResults = false;

  Future<void> fetchHomeworks() async {
    final response =
        await http.get(Uri.parse('https://my.api.mockaroo.com/stident_hw?key=7bf0ba50'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        originalHomeworks = jsonData.map((item) {
          return Homework(
            studentName: item['name'],
            studentAvatarUrl:
              item ['profile_picture'],
            date: item['date'],
          );
        }).toList();
        filteredHomeworks = List.from(originalHomeworks);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchHomeworks();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: 'الواجبات المرسله'),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Expanded( 
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  filteredHomeworks =
                                      List.from(originalHomeworks);
                                  showNoResults = false;
                                } else {
                                  filteredHomeworks = originalHomeworks
                                      .where((homework) =>
                                          homework.studentName.contains(value))
                                      .toList();
                                  showNoResults = filteredHomeworks.isEmpty;
                                }
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'ابحث عن الواجب',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<void>(
                  future: fetchHomeworks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.blue.shade900,),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (showNoResults)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'لا توجد نتائج',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              Container(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: filteredHomeworks.length,
                                  itemBuilder: (context, index) {
                                    var homework = filteredHomeworks[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Material(
                                                elevation: 5,
                                                shape: CircleBorder(),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    homework.studentAvatarUrl,
                                                  ),
                                                  radius: 30,
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  homework.studentName,
                                                ),
                                              ),
                                              Text(homework.date),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Card(
                                            elevation: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  // Button to display student's homework
                                                  CustomGradientButton(
                                                    buttonText: "عرض الحل",
                                                  ),
                                                  SizedBox(height: 10),
                                                  // Text field for teacher to add homework mark
                                                  TextFormField(
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    decoration: InputDecoration(
                                                      labelText: "اضف الدرجة",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty ||
                                                          !RegExp(r'^[0-9]+$')
                                                              .hasMatch(value)) {
                                                        return 'ادخل رقم فقط';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
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


