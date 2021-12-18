// import 'package:flutter/material.dart';
// import 'package:roaa_weather/core/animation/animation_route.dart';
// import 'package:roaa_weather/core/animation/basic_animation_page.dart';
//
// class SilverScreen extends StatelessWidget {
//   const SilverScreen({Key? key}) : super(key: key);
//
//   customAbbBarSilver() {
//     return SliverAppBar(
//       pinned: true,
//       stretch: true,
//       expandedHeight: 600,
//       backgroundColor: Colors.grey,
//       flexibleSpace: FlexibleSpaceBar(
//         title: Text("Weather App"),
//         background: Hero(
//           tag: 5,
//           child: Image.asset(
//             "assets/thunder.png",
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           customAbbBarSilver(),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 GestureDetector(
//                   onTap: () {
//                     // Navigator.of(context)
//                     //     .pushReplacement(SlidRight(page: AnimationPage()));
//                   },
//                   child: Column(
//                     children: const [
//                       Text(
//                         "slivers انا صفحه ليس لي علاقه بالتطبيق مجرد تجربه لل",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                       Text(
//                         "slivers انا صفحه ليس لي علاقه بالتطبيق مجرد تجربه لل",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                       Text(
//                         "slivers انا صفحه ليس لي علاقه بالتطبيق مجرد تجربه لل",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                       Text(
//                         "slivers انا صفحه ليس لي علاقه بالتطبيق مجرد تجربه لل",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                       Text(
//                         "slivers انا صفحه ليس لي علاقه بالتطبيق مجرد تجربه لل",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                       Text(
//                         "slivers انا صفحه ليس لي علاقه بالتطبيق مجرد تجربه لل",
//                         style: TextStyle(fontSize: 50),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
