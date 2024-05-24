import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/constant/searchbar.dart';
import 'package:abeermdrsty/view/teacher/components/drawer/custom_drawer.dart';


class descutiont extends StatefulWidget {
  @override
  _descutiontState createState() => _descutiontState();
}

class _descutiontState extends State<descutiont> {
  late StreamController<List<Map<String, dynamic>>> _notificationsStreamController;
  late List<Map<String, dynamic>> notifications;
  late List<Map<String, dynamic>> filteredNotifications;
  final TextEditingController _searchController = TextEditingController();
  String _selectedRecipientType = 'الكل'; // Default selected type

  @override
  void initState() {
    super.initState();
    notifications = [];
    filteredNotifications = notifications;

    _notificationsStreamController = StreamController<List<Map<String, dynamic>>>.broadcast();
    _notificationsStreamController.add(filteredNotifications);
    _searchController.addListener(() {
      _filterNotifications(_searchController.text);
    });
  }

  @override
  void dispose() {
    _notificationsStreamController.close();
    _searchController.dispose();
    super.dispose();
  }

  void _addNotification(Map<String, dynamic> notification) {
    notifications.add(notification);
    _filterNotifications('');
    _notificationsStreamController.add(filteredNotifications.toList());
  }

  void _editNotification(int index, Map<String, dynamic> newNotification) {
    notifications[index] = newNotification;
    _filterNotifications('');
    _notificationsStreamController.add(filteredNotifications.toList());
  }

  void _deleteNotification(int index) {
    notifications.removeAt(index);
    _filterNotifications('');
    _notificationsStreamController.add(filteredNotifications.toList());
  }

  void _filterNotifications(String query) {
    setState(() {
      filteredNotifications = notifications.where((notification) {
        final title = notification['العنوان'].toString().toLowerCase();
        final content = notification['الاشعار'].toString().toLowerCase();
        return title.contains(query.toLowerCase()) || content.contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showAddNotificationDialog({Map<String, dynamic>? notification, int? index}) {
    File? _file;

    void _selectFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          _file = File(result.files.single.path!);
        });
      }
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      builder: (BuildContext context) {
        return AddNotificationDialog(
          onSubmit: (notificationData) {
            if (_file != null) {
              notificationData['file'] = _file!.path;
            }
            if (index == null) {
              _addNotification(notificationData);
            } else {
              _editNotification(index, notificationData);
            }
          },
          notification: notification,
          selectedRecipientType: _selectedRecipientType,
          onRecipientTypeChanged: (type) {
            setState(() {
              _selectedRecipientType = type;
            });
          },
          file: _file,
          onSelectFile: _selectFile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: GestureDetector(
              onTap: () {
        // Hide keyboard when tapping anywhere on the screen
        FocusScope.of(context).unfocus();
      },
        child: Scaffold(
          appBar:appbarchild(title: "الاشعارات"),
            drawer: CustomDrawer(),
          body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _notificationsStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SearchBar(
                    controller: _searchController,
                            onChanged: (value) => _filterNotifications(value),
                  ),
                          if (filteredNotifications.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'لا توجد نتائج',
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredNotifications.length,
                        itemBuilder: (context, index) {
                          var notification = filteredNotifications[index];
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
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
                                    trailing: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'تعديل') {
                                          _showAddNotificationDialog(
                                            notification: notification,
                                            index: index,
                                          );
                                        } else if (value == 'حذف') {
                                          _deleteNotification(index);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem<String>(
                                          value: 'تعديل',
                                          child: Center(child: Text('تعديل')),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'حذف',
                                          child: Center(
                                            child: Text(
                                              'حذف',
                                              style: fonttitlestyle.fonttitle
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(notification['العنوان'],style:fonttitlestyle.fonttitle),
                                        Divider(
                                          thickness: 2,
                                        ),
                                        if (notification.containsKey('file')) // Check if the notification contains a file
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Image.asset(  
                                              notification['file']
                                              // "img/quran.jpg"
                                            ,)
          
                                          ),
                                        Text(
                                          notification['الاشعار'],
                                        style:fonttitlestyle.fonttitle,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("خطأ في جلب البيانات"),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddNotificationDialog(),
            tooltip: 'Add Notification',
            child: Icon(Icons.add),
            backgroundColor: Colors.blue.shade900,
          ),
        ),
      ),
    );
  }
}

class AddNotificationDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final Map<String, dynamic>? notification;
  final String selectedRecipientType;
  final ValueChanged<String> onRecipientTypeChanged;
  final File? file;
  final VoidCallback onSelectFile;

  AddNotificationDialog({
    required this.onSubmit,
    this.notification,
    required this.selectedRecipientType,
    required this.onRecipientTypeChanged,
    this.file,
    required this.onSelectFile,
  });

  @override
  _AddNotificationDialogState createState() => _AddNotificationDialogState();
}

class _AddNotificationDialogState extends State<AddNotificationDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                widget.notification == null ? 'اشعار جديد' : 'تعديل الاشعار',
                textAlign: TextAlign.center,
                style:fontstyle.fontheading
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
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("العنوان ",style:fontstyle.fontheading),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: _titleController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null; 
                          },
                        ),
                      ),
                    
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("الاشعار",style:fontstyle.fontheading),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _contentController,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            alignLabelWithHint: true,
                          ),
                        
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null; 
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: widget.onSelectFile,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: widget.file != null
                              ? Text(
                                  widget.file!.path,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.camera,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                      ),
                    
                    
                    
                    SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.blue.shade900],
                                ),
                              ),
                              child: Center(
                                child: Text('الغاء',style:fonttitlestyle.fonttitle),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final notificationData = {
                                  'العنوان': _titleController.text,
                                  'الاشعار': _contentController.text,
                                  'نوع المستلمين': widget.selectedRecipientType,
                                };
                                widget.onSubmit(notificationData);
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.blue.shade900],
                                ),
                              ),
                              child: Center(
                                child: Text(widget.notification != null ? 'تعديل' : 'ارسال',style:fonttitlestyle.fonttitle),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
