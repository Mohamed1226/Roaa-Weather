
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashNativeScreen extends StatefulWidget {
  const SplashNativeScreen({Key? key}) : super(key: key);

  @override
  _SplashNativeScreenState createState() => _SplashNativeScreenState();
}

class _SplashNativeScreenState extends State<SplashNativeScreen> {

  static const platform = MethodChannel('samples.flutter.dev/battery');

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('showSplash');
     batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
         onPressed: (){
           _getBatteryLevel();
         },
        child: Text(_batteryLevel.toString()),
      ),
    );
  }
}
