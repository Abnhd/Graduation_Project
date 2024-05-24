import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:abeermdrsty/constant/searchbar.dart';
import 'package:abeermdrsty/style/list.dart';
import 'package:abeermdrsty/view/manager/students.dart';



class Winer extends StatefulWidget {
  @override
  State<Winer> createState() => _WinerState();
}

class _WinerState extends State<Winer> {
  final TextEditingController _searchController = TextEditingController();
  List<clase> searchResults = [];
  bool _noResults = false;
  late Future<List<clase>> _futureSearchResults;

  @override
  void initState() {
    super.initState();
    _futureSearchResults = fetchClases(); // استدعاء الدالة للحصول على البيانات
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: "مدرستي"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SearchBar(
                controller: _searchController,
                onChanged: _filterNames,
                noResults: _noResults,
              ),
              Expanded(
                child: FutureBuilder<List<clase>>(
                  future: _futureSearchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("حدث خطأ أثناء تحميل البيانات"));
                    } else if (snapshot.hasData) {
                      // تحديث searchResults بالبيانات المستقبلة
                      searchResults = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _noResults ? 0 : searchResults.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StudentResultsPage(className: searchResults[index].title)),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.blue.shade900,
                                      Colors.blue.shade700,
                                      Colors.blue.shade700,
                                      Colors.blue.shade900
                                    ]),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  child: Center(
                                    child: Text(
                                      searchResults[index].title,
                                      style: fontwhite.fonttitle,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: Text("لا توجد نتائج"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterNames(String query) {
    setState(() {
      _noResults = false;
    });

    if (query.isEmpty) {
      setState(() {
        searchResults = clas;
      });
    } else {
      setState(() {
        searchResults = clas.where((clase) => clase.title.contains(query)).toList();
        _noResults = searchResults.isEmpty;
      });
    }
  }

  Future<List<clase>> fetchClases() async {
    // يمكنك هنا استبدال البيانات المستقبلية ببيانات حقيقية من السحابة أو أي مصدر آخر
    return Future.delayed(Duration(seconds: 2), () => clas);
  }
}

