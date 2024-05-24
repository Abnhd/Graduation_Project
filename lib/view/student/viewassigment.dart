import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';
import 'package:abeermdrsty/data/modles.dart';
import 'package:abeermdrsty/data/viewmdles.dart';
import 'package:abeermdrsty/repository/online_repo.dart';


import 'package:abeermdrsty/style/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/utility/endpoints.dart';
import 'package:abeermdrsty/view/student/components/drawer/custom_drawer.dart';
import 'package:provider/provider.dart';
 

class viewassigment extends StatefulWidget {
  @override
  _viewassigmentState createState() => _viewassigmentState();
}

class _viewassigmentState extends State<viewassigment> {
  String _searchText = '';

  void _deleteNotification(int index) {
    setState(() {
      noti.removeAt(index);
    });
  } 

  @override
  Widget build(BuildContext context) {
    // Filtered notifications based on search text
    final filteredNotifications = assig.where((notification) =>
        _searchText.isEmpty || notification.titile.contains(_searchText)).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar:appbarchild(title: "الواجبات"),
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
                child: filteredNotifications.isEmpty // Check if there are no filtered notifications
                    ? Center(
                        child: Text(
                          'لا توجد نتائج',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Consumer<Assigmentvm>(builder: (context, vm, Widget) {
                      return FutureBuilder(
                        future: vm.getassigment(OnlineRepo(),source: API_URL.Grads),
                        builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 30,
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData){
            List<Assigment> assigment =vm.assign;
            return ListView.builder(
                          itemCount: assigment.length,
                          itemBuilder: (context, index) {
                            Assigment assign = assigment[index];
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
                                              assign.lastName??"غلا بن بشر",
                                              style: fonttitlestyle.fonttitle,
                                            ),
                                          ),
                                          subtitle: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                            assign.birthDate??'',
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
                                                assign.lastName??"",
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
                                                          assign.maidenName??"",
                                                          style: fonttitlestyle.fonttitle,
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
                                     // جعلها أعرض 
                                  ), 
                                ),
                        //            Image.memory(
        //   base64Decode(base64String),
        //   fit: BoxFit.contain,
        // ),كود فك صوره مشفره
                                                          Divider(
                                                thickness: 2,
                                                color: Colors.grey.shade300,
                                                endIndent: 5,
                                                indent: 5,
                                              ),
                                                        Text(" موعد التسليم: ${assign.birthDate}"),
                                                        SizedBox(height: 10,),
                                                        Text("  درجة الواجب: ${assign.age}"),
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade700,
                      ),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          PlatformFile file = result.files.first;
                          // هنا يمكنك استخدام الملف المختار كما تشاء
                          print('تم اختيار الملف: ${file.name}');
                        } else {
                          // لم يتم اختيار أي ملف
                          print('لم يتم اختيار ملف');
                        }
                      },
                      icon: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                      label: Text(
                        "ادراج ملف",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                                SizedBox(height: 20),
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
                                                        "ملاحظات الاستاذ:",
                                                        style: fonttitlestyle.fonttitle,
                                                        ),
                                                        Text(assign.gender??"",
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            ElevatedButton(
                                                               style: ElevatedButton.styleFrom(
                                                                  primary: Colors.blue.shade700,
                                                                ),
                                                              onPressed: (){}, child: Text("الدرجة : ${assign.age}")),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                          
          }
            else {
              return const SizedBox(
                  height: 30,
                  child: CircularProgressIndicator(),
                );
              }
          
          });}))]))));
          }}
                      
            