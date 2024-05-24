import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';

import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/view/student/components/drawer/custom_drawer.dart';

class lesson extends StatefulWidget {
  @override
  _lessonState createState() => _lessonState();
}

class _lessonState extends State<lesson> {
  String _searchText = '';

  void _deleteNotification(int index) {
    setState(() {
      less.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtered notifications based on search text
    final filteredNotifications = less
        .where((notification) =>
            _searchText.isEmpty || notification.titile.contains(_searchText))
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "شروحات"),
        drawer: CustomDrawer(),
        body: GestureDetector(
          onTap: () {
            // Hide keyboard when tapping anywhere on the screen
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 9,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchText = value;
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
              Expanded(
                child: filteredNotifications
                        .isEmpty // Check if there are no filtered notifications
                    ? Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final notifi = filteredNotifications[index];
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: const CircleAvatar(
                                          backgroundImage:
                                              AssetImage("img/biology.jpg"),
                                        ),
                                        title: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            notifi.name,
                                            style: fonttitlestyle.fonttitle,
                                          ),
                                        ),
                                        subtitle: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            notifi.data,
                                          ),
                                        ),
                                        trailing: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'حذف') {
                                              _deleteNotification(index);
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            const PopupMenuItem<String>(
                                              value: 'حذف',
                                              child: Center(
                                                child: Text(
                                                  'حذف',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notifi.titile,
                                              style: fontstyle.fontheading,
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.indigo.shade400,
                                                    Colors.blue.shade400,
                                                    Colors.indigo.shade800,
                                                  ],
                                                ),
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        notifi.content,
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }
}
