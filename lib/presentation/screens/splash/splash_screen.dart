import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roaa_weather/core/app_route.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fadingAnimation;
  AppRoute? appRoute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appRoute = AppRoute();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fadingAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!)
          ..addListener(() {
            setState(() {
              if (animationController!.isCompleted) {
                animationController!.repeat(reverse: true);
              }
            });
          });

    animationController?.forward();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return appRoute!.isLogin();
      }));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         const   Text(
              "Splash Screen From Flutter",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            AnimatedBuilder(

              animation: fadingAnimation!,
              builder: (context, _) => Opacity(
                opacity: fadingAnimation?.value,
                child: const Text(
                  "Roaa Weather App",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
