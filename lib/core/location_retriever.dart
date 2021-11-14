
import 'package:geolocator/geolocator.dart';

class LocationRetriever{
  retrieve()async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}

