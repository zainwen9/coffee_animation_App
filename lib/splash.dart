import 'package:flutter/material.dart';
import 'package:stb/screens/home.dart';


class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    var d = Duration(seconds: 2);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash.png'),
          ),
        ),
      ),
    );
  }
}
