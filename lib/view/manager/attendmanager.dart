import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/constant/searchbar.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';


class attendmanager extends StatefulWidget {
  @override
  _attendmanagerState createState() => _attendmanagerState();
}

class _attendmanagerState extends State<attendmanager> {
  final TextEditingController _searchController = TextEditingController();
  bool _isBackPressed = false;
  List<String> names = ['أحمد', 'فاطمة', 'يوسف'];
  Map<String, bool> checkbox1Status = {};
  Map<String, bool> checkbox2Status = {};
  List<String> _filteredNames = [];

  @override
  void initState() {
    super.initState();
    // Initialize checkbox states
    for (String name in names) {
      checkbox1Status[name] = false;
      checkbox2Status[name] = false;
    }
    _filteredNames = names; // Start with all names displayed
  }

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = names; // Show all names if query is empty
      } else {
        _filteredNames = names.where((name) => name.contains(query)).toList();
      }
    });
  }
  void _saveAttendance() {
   
  }


  @override
  void _cancelAttendance() {
    setState(() {
      for (String name in names) {
        checkbox1Status[name] = false;
        checkbox2Status[name] = false;
      }
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: CustomAppBar(title: "مدرستي"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  SearchBar(
                    controller: _searchController,
                    onChanged: _filterNames,
                    noResults: _filteredNames.isEmpty && _searchController.text.isNotEmpty,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredNames.length,
                  itemBuilder: (context, index) {
                    String name = _filteredNames[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  name,
                                  textAlign: TextAlign.right,
                                  style: fonttitlestyle.fonttitle,
                                ),
                              ),
                              Checkbox(
                                value: checkbox1Status[name] ?? false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkbox1Status[name] = value ?? false;
                                  });
                                },
                                activeColor: Colors.green[700],
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                              ),
                              Text(
                                'حاضر',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.green[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Checkbox(
                                value: checkbox2Status[name] ?? false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkbox2Status[name] = value ?? false;
                                  });
                                },
                                activeColor: Colors.red[900],
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
                              ),
                              Text(
                                'غائب',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.red[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        

          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _saveAttendance();
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade900, Colors.blue],
                      ),
                    ),
                    child: Center(
                      child: Text(' حفظ', style: fontwhite.fonttitle),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _cancelAttendance();
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade900, Colors.blue],
                      ),
                    ),
                    child: Center(
                      child: Text('الغاء', style: fontwhite.fonttitle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// apppbar|||||||||||||||||||||||||||||||||||||||||||||||||||||


