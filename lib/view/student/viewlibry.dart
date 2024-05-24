import 'package:flutter/material.dart';
import 'package:abeermdrsty/constant/appbar.dart';
import 'package:abeermdrsty/constant/fontstyle.dart';


class Book {
  final String title;
  final String author;
  final String imageUrl;
  bool isLiked;
  bool download;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    this.isLiked = false,
    this.download = false,
  });
}

class Category {
  final String title;
  final List<Book> books;

  Category({
    required this.title,
    required this.books,
  });
}

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<Category> _categories = [];
  int _selectedCategoryIndex = 0;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    setState(() {
      // تمت كتابة قائمة الفئات لتجنب الخطأ الذي تمت مناقشته سابقًا
      _categories = [
        Category(
          title: 'الخيال',
          books: [
            Book(
              title: 'عنوان الكتاب الأول',
              author: 'Author 1',
              imageUrl: 'img/biology.jpg',
            ),
            Book(
              title: 'عنوان الكتاب الثاني',
              author: 'Author 2',
              imageUrl: 'img/english.jpg',
            ),
            Book(
              title: 'Book 2',
              author: 'Author 2',
              imageUrl: 'img/arabic.jpg',
            ),
          ],
        ),  Category(
          title: 'الخيال',
          books: [
            Book(
              title: 'عنوان الكتاب الأول',
              author: 'Author 1',
              imageUrl: 'img/biology.jpg',
            ),
            Book(
              title: 'عنوان الكتاب الثاني',
              author: 'Author 2',
              imageUrl: 'img/english.jpg',
            ),
            Book(
              title: 'Book 2',
              author: 'Author 2',
              imageUrl: 'img/arabic.jpg',
            ),
          ],
        ),
        Category(
          title: 'غير الخيال',
          books: [
            Book(
              title: 'عنوان الكتاب الثالث',
              author: 'Author 3',
              imageUrl: 'img/arabic.jpg',
            ),
          ],
        ),
        Category(
          title: 'العلوم',
          books: [
            Book(
              title: 'Book 2',
              author: 'Author 2',
              imageUrl: 'img/arabic.jpg',
            ),
            Book(
              title: 'Book 3',
              author: 'Author 3',
              imageUrl: 'img/english.jpg',
            ),
            Book(
              title: 'عنوان الكتاب الأول',
              author: 'Author 1',
              imageUrl: 'img/biology.jpg',
            ),
            Book(
              title: 'عنوان الكتاب الثاني',
              author: 'Author 2',
              imageUrl: 'img/english.jpg',
            ),
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // إخفاء لوحة المفاتيح
        FocusScope.of(context).unfocus();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Scaffold(
          appBar:CustomAppBar(title: "مدرستي",),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
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
                SizedBox(height: 10),
                Text(
                  'اقسام الكتب',
                  style: fontstyle.fontheading,
                ),
                SizedBox(height: 10),
                _buildCategoriesList(),
                SizedBox(height: 10),
                Text(
                  'الكتب',
                  style: fontstyle.fontheading,
                ),
                Expanded(
                  child: _buildBooksList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // الأدوات الرسومية الأخرى والمنطقية هي هناك نفس الشيء}


  Widget _buildCategoriesList() {
    List<Category> matchedCategories = _categories.where((category) {
      return category.title.contains(_searchText);
    }).toList();

    if (matchedCategories.isEmpty) {
      return Center(
        child: Text(
          'لم يتم العثور على نتائج بحث',
          style:fonttitlestyle.fonttitle,
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * .05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: matchedCategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = _categories.indexOf(matchedCategories[index]);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width *.25,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _selectedCategoryIndex == _categories.indexOf(matchedCategories[index])
                        ? Colors.blue.shade900
                        : Colors.blue.shade200,
                    _selectedCategoryIndex == _categories.indexOf(matchedCategories[index])
                        ? Colors.blue
                        : Colors.blueGrey.shade200,
                    _selectedCategoryIndex == _categories.indexOf(matchedCategories[index])
                        ? Colors.blue
                        : Colors.blueGrey.shade200,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  matchedCategories[index].title,
                  style: fontwhite.fonttitle
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBooksList() {
    Category selectedCategory = _categories[_selectedCategoryIndex];

    return ListView.builder(
      itemCount: selectedCategory.books.length,
      itemBuilder: (context, index) {
        Book book = selectedCategory.books[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Container(
          
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
            child: Card(
              elevation: 9,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width /4,
                      height:  MediaQuery.of(context).size.height /9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage(book.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ), SizedBox(width: MediaQuery.of(context).size.width *.01,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            book.title,
                            style: fonttitlestyle.fonttitle
                          ),
                          SizedBox(height: 4),
                          Text(
                            'by ${book.author}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade700,
                                ),
                                onPressed: () {
                                  setState(() {
                                    book.isLiked = !book.isLiked;
                                  });
                                },
                                icon: Icon(
                                  Icons.menu_book,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "عرض",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width *.01),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade700,
                                ),
                                onPressed: () {
                                  setState(() {
                                    book.download = !book.download;
                                  });
                                },
                                icon: Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "تنزيل",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


