// import 'dart:html';

// import 'package:collasable_drawer/components/drawer/custom_drawer.dart';
// import 'package:collasable_drawer/tabbar/classtab/class.dart';
// import 'package:collasable_drawer/wedgits/textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // For date formatting

// class notification extends StatefulWidget {
//   @override
//   _notificationState createState() => _notificationState();
// }

// class _notificationState extends State<notification> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController contentController = TextEditingController();
//   final TextEditingController deadlineController = TextEditingController();

//   String? submittedTitle;
//   String? submittedContent;
//   String? submittedDeadline;
//   DateTime? submissionDate;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("notification: "), elevation: 0),
//         endDrawer: const CustomDrawer(),
//         body: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 16),
//                   Expanded(
//                     child: TextFormField(
//                       controller: titleController,
//                       decoration: const InputDecoration(
//                         labelText: 'Task Title',
//                       ),
//                       validator: (val) {
//                         if (!val!.isValidTitle) {
//                           return 'Please enter a valid title';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Expanded(
//                     child: Container(
//                       height: 120,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextFormField(
//                         controller: contentController,
//                         maxLines: null,
//                         decoration: const InputDecoration(
//                           hintText: 'Write your task content here',
//                           contentPadding: EdgeInsets.all(8),
//                           border: InputBorder.none,
//                         ),
//                         validator: (val) {
//                           if (!val!.isValidContent) {
//                             return 'Please enter valid content';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: Stack(
//                           children: [
//                             Positioned.fill(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: <Color>[
//                                       Colors.blue.shade900,
//                                       Colors.blue.shade600,
//                                       Colors.blue.shade300,
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Center(
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     // Handle form submission (e.g., send data, save task)
//                                     submittedTitle = titleController.text;
//                                     submittedContent = contentController.text;
//                                     submittedDeadline = deadlineController.text;
//                                     // You can add logic here to handle document attachment
//                                     setState(() {}); // Update UI
//                                   }
//                                 },
//                                 child: const Text('Submit'),
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors
//                                       .transparent, // Transparent background
//                                   elevation: 0, // No shadow
//                                   textStyle: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () async {
//                           DateTime? deadlineDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime.now(),
//                             lastDate: DateTime(2100),
//                           );
//                           if (deadlineDate == null) return;

//                           TimeOfDay? deadlineTime = await showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay(hour: 12, minute: 0),
//                           );
//                           if (deadlineTime == null) return;

//                           final DateTime deadlineDateTime = DateTime(
//                             deadlineDate.year,
//                             deadlineDate.month,
//                             deadlineDate.day,
//                             deadlineTime.hour,
//                             deadlineTime.minute,
//                           );

//                           deadlineController.text =
//                               DateFormat('dd-MM-yyyy hh:mm')
//                                   .format(deadlineDateTime)
//                                   .toString();
//                         },
//                         icon: Icon(Icons.calendar_today),
//                       ),
//                     ],
//                   ),
//                   if (submittedTitle != null)
//                     Card(
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   ' $submittedTitle:',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 PopupMenuButton<String>(
//                                   onSelected: (value) {
//                                     if (value == 'edit') {
//                                       // Handle edit task
//                                     } else if (value == 'delete') {
//                                       // Handle delete task
//                                     }
//                                   },
//                                   itemBuilder: (context) => [
//                                     PopupMenuItem<String>(
//                                       value: 'edit',
//                                       child: Text('Edit'),
//                                     ),
//                                     PopupMenuItem<String>(
//                                       value: 'delete',
//                                       child: Text('Delete'),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8),
//                             // Text('Title: $submittedTitle'),
//                             Text('Content: $submittedContent'),
//                             Text('Deadline: $submittedDeadline'),
//                             SizedBox(height: 8),
//                             // Text('Submission Date: ${DateFormat('dd-MM-yyyy hh:mm').format(submissionDate)}'),
//                           ],
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

// }

// class Task {}

// extension StringValidation on String {
//   bool get isValidTitle => trim().isNotEmpty;
//   bool get isValidContent => trim().isNotEmpty;
// }

// class notification extends StatefulWidget {
//   @override
//   _notificationState createState() => _notificationState();
// }

// class _notificationState extends State<notification> {
//   final TextEditingController _textController = TextEditingController();
//   final FocusNode _myFocusNode = FocusNode();

//   String? _validateInput(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter some text';
//     }
//     // Add more validation rules as needed
//     return null; // Input is valid
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     _myFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Text Field Focus & Validation')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // TextField(
//             //   controller: _textController,
//             //   focusNode: _myFocusNode,
//             //   decoration: InputDecoration(
//             //     labelText: 'Enter text',
//             //     border: OutlineInputBorder(),
//             //   ),
//             //   // validator: _validateInput,
//             // ),
//             ElevatedButton(
//               onPressed: () => showModalBottomSheet(
//                   isScrollControlled: true,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18)),
//                   context: context,
//                   builder: (context) => addhwdialog()),
//               child: Text('Focus Text Field'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     if (Form.of(context)!.validate()) {
//             //       // Form is valid, process the input
//             //       print('Valid input: ${_textController.text}');
//             //     }
//             //   },
//             //   child: Text('Submit'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class addhwdialog extends StatelessWidget {
//   const addhwdialog({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(30),
//       height: MediaQuery.of(context).size.height * 0.75,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16), color: Colors.white),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//               width: double.infinity,
//               child: Text(
//                 "Add Homework",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               )),
//           Divider(
//             thickness: 1.2,
//             color: Colors.grey.shade200,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text(
//             "title",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           const textfieldwidget(maxline: 1, hinttext: "Add Title"),
//           const SizedBox(
//             height: 15,
//           ),
//           Text(
//             "Description",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           textfieldwidget(maxline: 5, hinttext: "Add Description"),
//           SizedBox(
//             height: 15,
//           ),
//         //   Text(
//         //     "Description",
//         //     textAlign: TextAlign.center,
//         //     style: TextStyle(
//         //         fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
//         //   ),
//         //   RadioListTile(title: Text("شرح"),value: 1, groupValue: 0, onChanged: (value){})
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(home: notification()));
// }

// import 'package:collasable_drawer/components/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/custom_drawer.dart';

// class loginScreen extends StatelessWidget {
//   const loginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         )    );
//   }
// }




class Grads extends StatefulWidget {
  const Grads({Key? key}) : super(key: key);

  @override
  State<Grads> createState() => _GradsState();
}

class _GradsState extends State<Grads> {
  late List<SubjectGrade> subjectsGrades;
  late TextEditingController _searchController;
  bool _isBackPressed = false;

  @override
  void initState() {
    super.initState();
    // Initialize subjects and grades for all buttons
    subjectsGrades = [
      SubjectGrade('القران الكريم', '90', '80', '70'),
      SubjectGrade('الاسلامية', '85', '75', '65'),
      SubjectGrade('اللغة العربية', '95', '85', '75'),
      SubjectGrade('العلوم', '90', '80', '70'),
      SubjectGrade('الرياضيات', '85', '75', '65'),
      SubjectGrade(' الانجليزي', '95', '85', '75'),
    ];
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF2F6FA), 
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'الواجبات',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blueGrey.shade400,
              Colors.blue.shade500,
              Colors.blueGrey.shade800,
            ])),
          ),
        ),// تغيير لون الخلفية
       drawer: const CustomDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo[900],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'ابحث...',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isBackPressed = true;
                        });
                        // Implement back button functionality
                      },
                      child: Container(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            shape: BoxShape.circle,
                            
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: _buildSearchResults(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    final List<SubjectGrade> searchResults = subjectsGrades.where((subject) {
      final searchText = _searchController.text.trim();
      return searchText.isEmpty ||
          subject.subject.contains(searchText);
    }).toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'لا توجد نتائج',
          style: TextStyle(color: Colors.black,
          fontSize: 20,
                    fontWeight: FontWeight.bold,),
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(searchResults[index]);
      },
    );
  }

  Widget _buildSubjectCard(SubjectGrade subjectGrade) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 350,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo.shade900, // لون الجزء العلوي من الكارد
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  subjectGrade.subject,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildGradeItem('الشهر الاول', subjectGrade.grade1),
            _buildGradeItem('الشهر الثاني', subjectGrade.grade2),
            _buildGradeItem('النهائي', subjectGrade.grade3),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeItem(String title, String grade) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
                fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            grade,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectGrade {
  final String subject;
  final String grade1;
  final String grade2;
  final String grade3;

  SubjectGrade(
    this.subject,
    this.grade1,
    this.grade2,
    this.grade3,
  );
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Grads',
//       debugShowCheckedModeBanner: false,
//       home: Grads(),
//     );
//   }
// }


