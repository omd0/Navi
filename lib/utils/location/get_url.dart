
import 'package:navi/utils/station.dart';
import 'package:url_launcher/url_launcher.dart';

String getMapUrl(Loc location) {
  double latitude = location.latitude;
  double longitude = location.longitude;
  String apiKey = 'AIzaSyDZ5SEoGCVzuY04wJCi86v_Gu21HUmcylQ'; // Replace with your actual API key
  int zoomLevel = 20;
  String baseUrl = 'https://maps.googleapis.com/maps/api/staticmap';
  String markerUrl =
      'markers=color:red%7Clabel:A%7C$latitude,$longitude'; // Optional: Add a marker to the location

  String url =
      '$baseUrl?center=$latitude,$longitude&zoom=$zoomLevel&size=400x400&$markerUrl&key=$apiKey';
  return url;
}

 Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }