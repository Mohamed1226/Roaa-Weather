import 'package:geolocator/geolocator.dart';
import 'package:roaa_weather/presentation/widget/app_toast.dart';

class LocationRetriever {
  // retrieve() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   return position;
  // }


  Future<Position> retrieve() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return appToast("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return appToast('Location permissions are denied');
      }
    }

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   return appToast(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
