// import 'package:collasable_drawer/login.dart';
// import 'package:collasable_drawer/tabbar/test.dart';
import 'package:flutter/material.dart';
import 'package:abeermdrsty/login.dart';
// import 'sign_in.dart';



class loadingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          _createPage(
              'Welcome to Mdrasty app all in one..! ',
              'Explore our features',
              'Let your child feel conforte',
              'img/madrsatylogor.jpg'),
          _createPage(
              'Enjoy our features!',
              '"Maintaining Your Data, is Our Priority" ',
              'ensuring peace of mind for all users',
              'img/securityr.jpg'),
          _createPage(
            'Get started now!',
            'Let dive in, discover featuress, ',
            'and unlock the full potential of education at your fingertips. 📚🚀',
            'img/peaplsr.jpg',
          ),
        ],
      ),
      floatingActionButton: _currentPage != 2
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.arrow_forward,
              ),
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
            )
          : FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.check),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTabLogin()),
                );
              },
            ),
    );
  }

  Widget _createPage(
      String title, String subtitle1, String subtitle2, String assetName) {
    return Stack(
      children: <Widget>[
        // Image container
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade100,
            image: DecorationImage(
              image: AssetImage(assetName), // Replace with your image path
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        // Text container (positioned under the image)
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.all(10),
            width: 300,
            height: 150,
            // color: Colors.black54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 8), // Adjust the spacing between lines
                Text(
                  subtitle1,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.indigo.shade700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle2,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.indigo.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: MyTabs());
//   }
// }
