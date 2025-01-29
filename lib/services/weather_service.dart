import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '05522d11f96542fc8fb173216252801'; // Replace with your WeatherAPI key
  final String baseUrl = 'https://api.weatherapi.com/v1';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city&aqi=no');
    print('Fetching weather from: $url'); // Debugging line

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('City not found: $city');
      } else {
        throw Exception('Failed to fetch weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
