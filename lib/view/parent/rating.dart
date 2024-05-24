import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbarchild.dart';

import 'package:abeermdrsty/constant/fontstyle.dart';

import 'drawer/custom_drawer.dart';

class Ratingparent extends StatefulWidget {
  @override
  _RatingparentState createState() => _RatingparentState();
}

class _RatingparentState extends State<Ratingparent> {
  String teacherName = 'الأستاذ فلان'; // اسم الاستاذ
  String? performanceRating; // تقييم الأداء
  String? styleRating; // تقييم الأسلوب

  List<String> ratingOptions = ['ممتاز', 'جيد', 'متوسط', 'ضعيف'];

void saveRating() {
  if (performanceRating != null && styleRating != null) {
    // تحويل التقييمات النصية إلى قيم رقمية
    int performanceValue = ratingOptions.indexOf(performanceRating!);
    int styleValue = ratingOptions.indexOf(styleRating!);

    // حساب المتوسط
    double averageRating = (performanceValue + styleValue) / 2;

    // تحويل الناتج إلى نسبة مئوية
    double finalRating = averageRating * 100 / (ratingOptions.length - 1); // -1 لاحتساب عدد الخيارات بشكل صحيح

    // حفظ التقييم
    print('تم حفظ التقييم: $finalRating%');
    // يمكنك هنا استخدام قيمة finalRating لحفظ التقييم بالنسبة المئوية
  } else {
    print('الرجاء اختيار التقييم');
  }
}


  void clearRating() {
    setState(() {
      performanceRating = null;
      styleRating = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appbarchild(title: "التقييم"),
        drawer: Drawerparent(),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .20,
              ), // الارتفاع لتقليل مساحة الكارد العلوية
              Container(
                height: MediaQuery.of(context).size.height * .35,
                  decoration: BoxDecoration(
                              gradient: LinearGradient(
              colors: [
                Colors.indigo.shade400,
                Colors.blue.shade400,
                Colors.indigo.shade800,
              ],
            ),
                              shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(Radius.circular(10))
                              
                            ),
                child: Column(
                  children: [
                    ListTile(
                      title: Center(child: Text("أ.محمد كعدان", style: fontwhite.fonttitle,)),
                    ),
                    Column(
                      children: [
                        // تقييم الأداء
                        Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('تقييم الأداء',  style: fonttitlestyle.fonttitle),
                                SizedBox(width: 20),
                                DropdownButton<String>(
                                  hint: Text('اختر التقييم', ),
                                  value: performanceRating,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      performanceRating = newValue;
                                    });
                                  },
                                  items: ratingOptions.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color: Colors.black)),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                        Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('تقييم الأسلوب', style: fonttitlestyle.fonttitle),
                                SizedBox(width: 20),
                                DropdownButton<String>(
                                
                                  hint: Text('اختر التقييم', ),
                                  value: styleRating,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      styleRating = newValue;
                                    });
                                  },
                                  items: ratingOptions.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: TextStyle(color: Colors.black)),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                          
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: saveRating,
                                child: Text('حفظ', style: fontstyle.fontheading,),
                              ),
                              // زر الغاء التقييم
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: clearRating,
                                child: Text('الغاء', style: fontstyle.fontheading),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
