// import 'package:flutter/material.dart';
// import 'package:flutter_slider_puzzle/levels/level_1/level_1.dart';
// import 'package:flutter_slider_puzzle/levels/level_1/level_one.dart';
// import 'package:flutter_slider_puzzle/levels/level_3/level_three.dart';
// import 'package:flutter_slider_puzzle/levels/level_5/level_five.dart';
//
// import 'levels/level_2/level_two.dart';
// import 'levels/level_4/level_four.dart';
//
// class MainGamePage extends StatefulWidget {
//   const MainGamePage({Key? key}) : super(key: key);
//
//   @override
//   MainGameState createState() => MainGameState();
// }
//
// class MainGameState extends State<MainGamePage> {
//   Level1 level1 = Level1();
//   var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 0];
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
//         body: Container(
//           color: Colors.blue,
//           child: Stack(
//             children: [
//               Positioned(
//                   top: size.height / 10,
//                   left: size.width / 2.8,
//                   child: const Text(
//                     "Choose a Level:",
//                     style: TextStyle(
//                         fontSize: 30,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold),
//                   )),
//               Column(
//                 children: [
//                   Container(
//                     height: size.height,
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 250.0, right: 250.0, top: 100),
//                       child: GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   mainAxisExtent: 60,
//                                   crossAxisCount: 3,
//                                   mainAxisSpacing: 20,
//                                   crossAxisSpacing: 20),
//                           itemCount: numbers.length,
//                           itemBuilder: (context, index) {
//                             return numbers[index] != 0
//                                 ? SizedBox(
//                                     height: 50,
//                                     width: 50,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         if (index == 0) {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const LevelOne()));
//                                         } else if (index == 1) {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const LevelTwo()));
//                                         } else if (index == 2) {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const LevelThree()));
//                                         } else if (index == 3) {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const LevelFour()));
//                                         } else if (index == 4) {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const LevelFive()));
//                                         }
//                                       },
//                                       child: Text(
//                                         "${numbers[index]}",
//                                         style: const TextStyle(
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black),
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                           fixedSize: const Size(50, 50),
//                                           primary: Colors.white,
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8.0))),
//                                     ),
//                                   )
//                                 : const SizedBox.shrink();
//                           }),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
