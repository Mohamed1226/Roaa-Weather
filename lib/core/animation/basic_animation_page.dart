// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
//
// class AnimationPage extends StatefulWidget {
//   const AnimationPage({Key? key}) : super(key: key);
//
//   @override
//   State<AnimationPage> createState() => _AnimationPageState();
// }
//
// class _AnimationPageState extends State<AnimationPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<double> animation;
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     animationController.dispose();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     animationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 5));
//     final curvedAnmation = CurvedAnimation(
//         parent: animationController, curve: Curves.bounceIn,
//     reverseCurve: Curves.easeOut
//     );
//     animation =
//     Tween<double>(begin: 0, end: 2 * 3.14).animate(curvedAnmation)
//       ..addListener(() {
//         if (animationController.isCompleted) {
//           animationController.repeat(reverse: true);
//         }
//         setState(() {});
//       });
//     animationController.forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Transform.rotate(
//           angle: animation.value,
//           child: Container(
//             padding: const EdgeInsets.all(30),
//             child: Image.asset("assets/face.jpg"),
//           ),
//         ),
//       ),
//     );
//   }
// }
