

import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/view/parent/drawer/custom_drawer.dart';






class notificationparent extends StatefulWidget {
  @override
  _notificationparentState createState() => _notificationparentState();
}

class _notificationparentState extends State<notificationparent> {
    void _deleteNotification(int index) {
    setState(() {
      noti.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
  
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
       appBar: CustomAppBar(title: 'الاشعارات'),
        drawer: Drawerparent(),
        body: ListView.builder(
          itemCount: noti.length,
          itemBuilder: (context, index) {
            final notification = noti[index];
          
    
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card( 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                    leading  : const CircleAvatar(
                      backgroundImage:AssetImage("images/1.jpg"),
                      ),
                      title:  Align(alignment: Alignment.topRight,
                        child: Text(
                      notification.name,
                        style: fonttitlestyle.fonttitle,
                        ),
                        
                      ),
                      subtitle:    Align(alignment: Alignment.topRight,
                        child: Text(
                          // '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                          notification.data
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                          if (value == 'حذف') {
                          _deleteNotification(index);
                        }
                      },
                      itemBuilder: (context) => [
                    
                      const  PopupMenuItem<String>(
                          value: 'حذف',
                          child: Center(
                            child: Text('حذف'
                            ,style: TextStyle(color: Colors.red,fontSize: 17,  fontWeight: FontWeight.bold,),),
                          ),
                        ),
                      ],
                    ),
                      // Timestamp on the top left corner
                    
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          notification.titile,
                            style: fontstyle.fontheading
                          ),
                           SizedBox(
                            height: 20,
                          ),
                          Text(
                            notification.content,
                            style: fonttitlestyle.fonttitle)
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
    );
  }

  
}
