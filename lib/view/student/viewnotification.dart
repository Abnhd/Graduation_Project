import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';


import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/view/student/components/drawer/custom_drawer.dart';

class viewnotifisuper extends StatefulWidget {
  @override
  _viewnotifisuperState createState() => _viewnotifisuperState();
}

class _viewnotifisuperState extends State<viewnotifisuper> {
  String _searchText = '';
    TextEditingController _searchController = TextEditingController();

  void _deleteNotification(int index) {
    setState(() {
      noti.removeAt(index);
    });
  }
    @override
  void dispose() {
    _searchController.dispose(); // التخلص من متحكم البحث عند التخلص من الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtered notifications based on search text
    final filteredNotifications = noti.where((notification) =>
        _searchText.isEmpty || notification.titile.contains(_searchText)).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "مدرستي",),
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
                            controller: _searchController,
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
                child: filteredNotifications.isEmpty // Check if there are no filtered notifications
                    ? Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: fonttitlestyle.fonttitle
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: const CircleAvatar(
                                          backgroundImage: AssetImage("img/biology.jpg"),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notifi.titile,
                                              style: fontstyle.fontheading,
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: Colors.grey.shade300,
                                              endIndent: 5,
                                              indent: 5,
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.indigo.shade400,
                                                    Colors.blue.shade400,
                                                    Colors.indigo.shade800,
                                                  ],
                                                ),
                                                shape: BoxShape.rectangle,
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 4,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                    
                    Text(
                                                        notifi.content,
                                                          style:fonttitlestyle.fonttitle,
                                                      ),
                                                        GestureDetector( 
                                  onTap: () { 
                                    showDialog( 
                                      context: context, 
                                      builder: (BuildContext context) { 
                                        return Dialog( 
                                          child: Container( 
                                            decoration: BoxDecoration( 
                                              borderRadius: 
                                                  BorderRadius.circular(16), 
                                              image: DecorationImage( 
                                                image: AssetImage( 
                                                    "img/biology.jpg"), 
                                                fit: BoxFit.cover, 
                                              ), 
                                            ), 
                                            height: MediaQuery.of(context) 
                                                    .size 
                                                    .height * 
                                                0.8, 
                                            width: MediaQuery.of(context) 
                                                    .size 
                                                    .width * 
                                                0.8, 
                                          ), 
                                        ); 
                                      }, 
                                    ); 
                                  }, 
                                  child: Container( 
                                    decoration: BoxDecoration( 
                                      borderRadius: BorderRadius.circular(16), 
                                      image: DecorationImage( 
                                        image: AssetImage("img/biology.jpg"), 
                                        fit: BoxFit.cover, 
                                      ), 
                                    ), 
                                    height: MediaQuery.of(context).size.height * 
                                        0.2, 
                                  
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
