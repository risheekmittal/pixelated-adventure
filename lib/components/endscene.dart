import 'package:flutter/material.dart';
import 'package:flutter_slider_puzzle/components/touch_one.dart';

class Ending extends StatefulWidget {
  const Ending({Key? key}) : super(key: key);

  @override
  _EndingState createState() => _EndingState();
}

class _EndingState extends State<Ending> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FirstLevel()));
    });
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
        changeOpacity();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedOpacity(
        opacity: opacity == 1 ? 0 : 1,
        duration: Duration(seconds: 1),
        child: Center(
            child: Text(
          'FOR ONE LAST TIME',
          style: TextStyle(
              fontFamily: 'RedPixel', fontSize: 80, color: Colors.white),
        )),
      ),
    );
  }
}
