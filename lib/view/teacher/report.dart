import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/custom_drawer.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Report> reports = [];
  DateTime? _selectedDate;
  List<Report> _filteredReports = [];

  void _addReport(String reportText) {
    setState(() {
      reports.add(Report(reportText, DateTime.now()));
      _filterReports();
    });
  }

  void _showAddReportDialog() {
    String newReportText = '';
    bool isButtonEnabled = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('اضف تقرير يومي'),
              content: TextField(
                onChanged: (text) {
                  setState(() {
                    newReportText = text;
                    isButtonEnabled = newReportText.isNotEmpty;
                  });
                },
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'اكتب تقريرك هنا',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('الغاء'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('ارسال'),
                  onPressed: isButtonEnabled
                      ? () {
                          if (newReportText.isNotEmpty) {
                            _addReport(newReportText);
                          }
                          Navigator.of(context).pop();
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _filterReports();
      });
    }
  }

  void _filterReports() {
    if (_selectedDate == null) {
      _filteredReports = reports;
    } else {
      _filteredReports = reports
          .where((report) =>
              report.date.year == _selectedDate!.year &&
              report.date.month == _selectedDate!.month &&
              report.date.day == _selectedDate!.day)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    _filterReports();

    return Scaffold(
      appBar: CustomAppBar(title: "تقرير اليومي"),
      endDrawer: CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _pickDate,
                ),
                Text(
                  _selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                      : 'لم يتم تحديد التاريخ',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredReports.isEmpty
                ? Center(child: Text('لا توجد تقارير'))
                : ListView.builder(
                    itemCount: _filteredReports.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            _filteredReports[index].text,
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text(
                            DateFormat('yyyy-MM-dd – kk:mm')
                                .format(_filteredReports[index].date),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReportDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.shade900,
        
      ),
    );
  }
}

class Report {
  String text;
  DateTime date;

  Report(this.text, this.date);
}
