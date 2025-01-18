import 'dart:convert';

import 'package:robot_slider/home_page.dart';
import 'package:robot_slider/ip_storage.dart';
import 'package:http/http.dart' as http;

class ApiServices {
   final IPStorageService _ipStorageService = IPStorageService();


  String get baseUrl {
    return _ipStorageService.getIp();
  }
  
 Future<void> sendSliderValues(Map<String, double> sliderValues) async {
    final url = Uri.parse('http://$baseUrl/sliderValues');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(sliderValues),
      );

      if (response.statusCode == 200) {
        print('Slider values sent successfully: ${response.body}');
      } else {
        print('Failed to send slider values. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending slider values: $error');
    }
  }
}



