// import 'package:collasable_drawer/wedgits/appbar.dart';
import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';



class ScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeeklySchedule(),
    );
  }
}

class WeeklySchedule extends StatefulWidget {
  @override
  _WeeklyScheduleState createState() => _WeeklyScheduleState();
}

class _WeeklyScheduleState extends State<WeeklySchedule> {
  int _currentIndex = 0;
  final List<String> daysOfWeek = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'خميس'
  ];

  Map<String, List<List<String>>> scheduleData = {
    'الأحد': [
      ['8:00 AM', 'Class 1', 'حصة 1'],
      ['9:00 AM', 'Class 2', 'حصة 2'],
      ['10:00 AM', 'Class 3', 'حصة 3'],
    ],
    'الاثنين': [
      ['8:00 AM', 'Class 1', 'حصة 1'],
      ['9:00 AM', 'Class 2', 'حصة 2'],
      ['10:00 AM', 'Class 3', 'حصة 3'],
      ['11:00 AM', 'Class 4', 'حصة 4'],
    ],
    'الثلاثاء': [
      ['8:00 AM', 'Class 1', 'حصة 1'],
      ['9:00 AM', 'Class 2', 'حصة 2'],
      ['10:00 AM', 'Class 3', 'حصة 3'],
      ['11:00 AM', 'Class 4', 'حصة 4'],
      ['12:00 PM', 'Class 5', 'حصة 5'],
    ],
    'الأربعاء': [
      ['8:00 AM', 'Class 1', 'حصة 1'],
      ['9:00 AM', 'Class 2', 'حصة 2'],
      ['10:00 AM', 'Class 3', 'حصة 3'],
      ['11:00 AM', 'Class 4', 'حصة 4'],
      ['12:00 PM', 'Class 5', 'حصة 5'],
      ['1:00 PM', 'Class 6', 'حصة 6'],
    ],
    'خميس': [
      ['8:00 AM', 'Class 1', 'حصة 1'],
      ['9:00 AM', 'Class 2', 'حصة 2'],
      ['10:00 AM', 'Class 3', 'حصة 3'],
      ['11:00 AM', 'Class 4', 'حصة 4'],
      ['12:00 PM', 'Class 5', 'حصة 5'],
      ['1:00 PM', 'Class 6', 'حصة 6'],
      ['2:00 PM', 'Class 7', 'حصة 7'],
    ],
  };

  void _previousDay() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % daysOfWeek.length;
      if (_currentIndex < 0) _currentIndex = daysOfWeek.length - 1;
    });
  }

  void _nextDay() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % daysOfWeek.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
       textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'جدول الأسبوع',
         
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: _previousDay,
                    color: Colors.blueAccent, // لون الأيقونة
                  ),
                  Text(
                    daysOfWeek[_currentIndex],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: _nextDay,
                    color: Colors.blueAccent, // لون الأيقونة
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      scheduleData[daysOfWeek[_currentIndex]]!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5),
                        child: Card(
                          color: (index + 1) % 2 == 0
                              ? Colors.indigo
                              : Colors
                                  .lightBlue.shade50, // تحديد لون الكارد بناءً على رقم الحصة
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildScheduleButton('${index + 1}'), // رقم الحصة
                                SizedBox(width: 10),
                                _buildScheduleButton(scheduleData[
                                        daysOfWeek[_currentIndex]]![index]
                                    [1]), // اسم الصف
                                SizedBox(width: 10),
                                _buildScheduleButton(scheduleData[
                                        daysOfWeek[_currentIndex]]![index]
                                    [0]), // الساعة
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleButton(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
