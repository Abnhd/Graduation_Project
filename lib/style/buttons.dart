// import 'package:flutter/material.dart';
// class buttonstyle extends StatelessWidget {

//   const buttonstyle({
//     Key? key,
//     required this.buttondhight,
//     required this.btuoonwidth,
//   }) : super(key: key);

//   final double buttondhight;
//   final double btuoonwidth;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//       final btuoonwidth = size.width * .20;
//     final buttondhight = size.height * .05;
//     return Container(
//       height:buttondhight  ,
//       width: btuoonwidth ,
//       decoration:
//           BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
//         BoxShadow(
//           color: Colors.blue.shade900,
//           spreadRadius: 1,
//           blurRadius: 1,
//           offset: Offset(4, 3),
//         ),
//         const BoxShadow(
//           color: Colors.white,
//           spreadRadius: 2,
//           // blurRadius: 2,
//           offset: Offset(-5, -5),
//         )
//       ]),
//       child: const Center(
//         child: Text(
//           "حفظ",
//           style: TextStyle(
//               color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
import 'package:abeermdrsty/constant/fontstyle.dart';
import 'package:flutter/material.dart';


class button extends StatelessWidget {
  const button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade400,
          Colors.blue.shade400,
          Colors.indigo.shade800,
        ],
      ),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
    ));
  }
}

class buttoon extends StatelessWidget {
  const buttoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade900, Colors.blue],
          ),
        ),
        child: Center(
          child: Text(' حفظ', style: fontwhite.fonttitle),
        ),
      ),
    );
  }
}
