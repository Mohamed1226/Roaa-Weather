import 'package:flutter/cupertino.dart';
import 'package:roaa_weather/core/widget/app_toast.dart';

class SlidRight extends PageRouteBuilder {
  final page;

  SlidRight({required this.page})
      : super(
          pageBuilder: (context, animation, animationTwo) => page,
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, animationTwo, child) {
            // var tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
            // var offsetAnimation = animation.drive(tween);

            animation =
                CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
            //  appToast("HEY I AM Animation...");
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            );
          },
        );
}
