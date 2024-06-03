import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/buttoncolor.dart';
import 'package:abeermdrsty/constant/searchbar.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/custom_drawer.dart';
import 'package:abeermdrsty/view/teacher/tabbar/classtab/homeworknotification/viewhw.dart';
import 'package:abeermdrsty/view/teacher/tabbar/test.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class diary extends StatefulWidget {
  @override
  _diaryState createState() => _diaryState();
}

class _diaryState extends State<diary> {
  List<Map<String, dynamic>> notifications = [];
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredNames = [];
  bool _isBackPressed = false;

  void _filterNames(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredNames = notifications
            .map((notification) => notification['title'] as String)
            .toList();
      } else {
        _filteredNames = notifications
            .where((notification) => notification['title'].contains(query))
            .map((notification) => notification['title'] as String)
            .toList();
      }
    });
  }

  void _addNotification(Map<String, dynamic> notification) {
    setState(() {
      notifications.add(notification);
      _filteredNames = notifications
          .map((notification) => notification['title'] as String)
          .toList();
    });
  }

  void _editNotification(int index, Map<String, dynamic> newNotification) {
    setState(() {
      notifications[index] = newNotification;
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }
final String videoUrl = 'https://www.youtube.com/watch?v=exampleVideoId';
  void launchUrl(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
    // ignore: deprecated_member_use
    await launch(url);
  }
  void _showAddNotificationDialog(
      {Map<String, dynamic>? notification, int? index}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      builder: (BuildContext context) {
        return AddNotificationDialog(
          onSubmit: (notificationData) {
            if (index == null) {
              _addNotification(notificationData);
            } else {
              _editNotification(index, notificationData);
            }
          },
          notification: notification,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(title: 'شروحات'),
        resizeToAvoidBottomInset: false,
        endDrawer: const CustomDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                SearchBar(
                  controller: _searchController,
                  onChanged: _filterNames,
                  noResults: _filteredNames.isEmpty &&
                      _searchController.text.isNotEmpty,
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _filteredNames.length,
              itemBuilder: (context, index) {
                var notificationTitle = _filteredNames[index];
                var notification = notifications.firstWhere((notification) =>
                    notification['title'] == notificationTitle);

                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4, // Remove card elevation
                            color: Colors.white, // Transparent card background
                            child: Column(children: [
                              ListTile(
                                trailing: CircleAvatar(
                                  backgroundImage: AssetImage("img/quran.jpg"),
                                ),
                                title: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'غلا بن بشر',
                                  ),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    // '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                                    "2/2/2020",
                                  ),
                                ),
                                leading: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _showAddNotificationDialog(
                                        notification: notification,
                                        index: index,
                                      );
                                    } else if (value == 'delete') {
                                      _deleteNotification(index);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem<String>(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ), // Three dots on the left side

                                // Timestamp on the top left corner
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      "الدرس:${notification['title']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05, // Adjust font size
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey.shade700,
                                    height: 5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    notification['content'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(padding:  
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () => launchUrl(
                                                        videoUrl), // Open YouTube link
                                                    child: const Text('يوتيوب'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    // Open YouTube link
                                                    child:
                                                        const Text('عرض ملف'),
                                                  ),
                                                ],
                                              ),)
                                ],
                              ),
                            ])))
                  ],
                );
              },
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddNotificationDialog(),
          tooltip: 'اضف اشعار ',
          child: Icon(Icons.add),
          backgroundColor: Colors.blue.shade900,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Grads()),
    );
    return false;
  }
}

class AddNotificationDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final Map<String, dynamic>? notification;

  AddNotificationDialog({required this.onSubmit, this.notification});

  @override
  _AddNotificationDialogState createState() => _AddNotificationDialogState();
}

class _AddNotificationDialogState extends State<AddNotificationDialog> {
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime _deadline = DateTime.now();
  String? _attachedFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.notification != null) {
      _titleController.text = widget.notification!['title'];
      _contentController.text = widget.notification!['content'];
      _deadline = widget.notification!['deadline'];
      _attachedFile = widget.notification!['file'];
    }
  }

  void _submit() {
    final notificationData = {
      'title': _titleController.text,
      'content': _contentController.text,
      'deadline': _deadline,
      'timestamp': DateTime.now(),
      'file': _attachedFile,
    };
    widget.onSubmit(notificationData);
    Navigator.of(context).pop();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _attachedFile = result.files.single.path;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline),
    );
    if (picked != null) {
      setState(() {
        _deadline = DateTime(
          _deadline.year,
          _deadline.month,
          _deadline.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.notification == null ? 'شرح جديد' : 'تعديل الشرح',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Divider(
                        thickness: 1.2,
                        color: Colors.grey.shade200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: const Text(
                          "الدرس",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8)),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _titleController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "عنوان الدرس",
                            alignLabelWithHint: true,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null; // Input is valid
                          },
                        ),
                      ),
                      
                    
                            Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          "الشرح",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: _contentController,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              alignLabelWithHint: true,
                              hintText: "محتوى الشرح",
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter content';
                              }
                              return null; // Input is valid
                            },
                          )),
                            Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          "اضف الرابط",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8)),
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            controller: _urlController,
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              alignLabelWithHint: true,
                              hintText: "الرابط",
                            ),
                            maxLines: 5,
                          
                          )),
                      ListTile(
                        title: Text(_attachedFile != null
                            ? 'File attached'
                            : 'Attach file'),
                        trailing: Icon(Icons.attach_file),
                        onTap: _pickFile,
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomGradientButton(
                            buttonText: 'الغاء',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            // hasHomework:
                            //     false, // Set hasHomework to false for the Cancel button
                          ),
                          CustomGradientButton(
                            buttonText:
                                widget.notification != null ? 'تعديل' : 'ارسال',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submit();
                              }
                            },
                            hasHomework:
                                true, // Assuming the Edit/Submit button has homework
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
