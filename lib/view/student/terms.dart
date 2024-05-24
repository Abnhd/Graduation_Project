import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';



import 'package:abeermdrsty/style/fontstyle.dart';


import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/view/student/info_subject.dart';
import 'package:abeermdrsty/view/student/pdf.dart';

class TermPage extends StatefulWidget {

  _TermPageState createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
  String _selectedTerm = 'الترم الأول'; // تحديد "الترم الأول" كترم افتراضي

  List<String> _firstTermSubjects = [
    'Subject 1',
    'Subject 2',
    'Subject 3',
    'Subject 3',
    'Subject 1',
    'Subject 2',
    'Subject 3',
    'Subject 3'
  ];
  List<String> _secondTermSubjects = [
    'Subject A',
    'Subject B',
    'Subject C',
    'Subject 3'
  ];
  List<String> _firstTermSubjectImages = [
    'img/biology.jpg',
    'img/quran.jpg',
    'img/eslamic.jpg',
    'img/quran.jpg',
    'img/biology.jpg',
    'img/quran.jpg',
    'img/eslamic.jpg',
    'img/quran.jpg',
  ];
  List<String> _secondTermSubjectImages = [
    'img/biology.jpg',
    'img/english.jpg',
    'img/biology.jpg',
    'img/quran.jpg',
  ];
  List<String> _firstTermPdfPaths = [
    'assets/pdf/subject1.pdf',
    'assets/pdf/subject2.pdf',
    'assets/pdf/subject3.pdf',
    'assets/pdf/subject3.pdf',
    'assets/pdf/subject1.pdf',
    'assets/pdf/subject2.pdf',
    'assets/pdf/subject3.pdf',
    'assets/pdf/subject3.pdf',
  ];
  List<String> _secondTermPdfPaths = [
    'assets/pdf/subjectA.pdf',
    'assets/pdf/subjectB.pdf',
    'assets/pdf/subjectC.pdf',
    'assets/pdf/subject3.pdf',
  ];
  String _searchText = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // تحديد "الترم الأول" كترم افتراضي
    _selectedTerm = 'الترم الأول';
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final filteredSubjects = _selectedTerm == 'الترم الأول'
        ? _firstTermSubjects
            .where((subject) => subject.contains(_searchText))
            .toList()
        : _secondTermSubjects
            .where((subject) => subject.contains(_searchText))
            .toList();

    

    return Scaffold(
      appBar: CustomAppBar(
        title: "مدرستي",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            hintText: 'ابحث ...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Perform search functionality here
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTerm = 'الترم الأول';
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
                          colors: [
                            _selectedTerm == 'الترم الأول'
                                ? Colors.blue.shade900
                                : Colors.blue.shade200,
                            _selectedTerm == 'الترم الأول'
                                ? Colors.blue
                                : Colors.grey,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text('الترم الأول', style: fontwhite.fonttitle),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTerm = 'الترم الثاني';
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
                          colors: [
                            _selectedTerm == 'الترم الثاني'
                                ? Colors.blue.shade900
                                : Colors.blue.shade200,
                            _selectedTerm == 'الترم الثاني'
                                ? Colors.blue
                                : Colors.grey,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text('الترم الثاني', style: fontwhite.fonttitle),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              filteredSubjects.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: filteredSubjects.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String pdfPath = _selectedTerm == 'الترم الأول'
                                          ? _firstTermPdfPaths[index]
                                          : _secondTermPdfPaths[index];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => bookpdf()));
                                    },
                                    child: Image.asset(
                                      _selectedTerm == 'الترم الأول'
                                          ? _firstTermSubjectImages[index]
                                          : _secondTermSubjectImages[index],
                                      // يتم ضبط ارتفاع الصورة بنفس قيمة العرض
                                      height: 140,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9, horizontal: 17),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue.shade900,
                                            Colors.blue.shade200
                                          ],
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Text(
                                        filteredSubjects[
                                            index], // You can replace this with the actual book title
                                        style: fontwhite16.fonttitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : _searchController.text.isNotEmpty
                      ? Center(
                          child: Text(
                            'لا توجد نتائج',
                            style: fontstyle.fontheading
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }


}


