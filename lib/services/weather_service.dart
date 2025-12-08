import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hava_durumu/core/constants.dart';
import 'package:flutter_hava_durumu/models/weather_model.dart';
import 'package:flutter_hava_durumu/models/location_info.dart';

class WeatherService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      queryParameters: {
        "appid": AppConstants.apiKey,
        "units": "metric",
        "lang": "tr",
      },
    ),
  );

  // Geocoding API uses a different path, so we use a separate Dio instance or full URL
  final Dio _geoDio = Dio(
    BaseOptions(
      baseUrl: 'http://api.openweathermap.org/geo/1.0/',
      queryParameters: {
        "appid": AppConstants.apiKey,
      },
    ),
  );

  Future<WeatherModel?> getWeather(String city) async {
    try {
      final response = await _dio.get('weather', queryParameters: {'q': city});
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      print('Hava durumu alınırken hata: $e');
    }
    return null;
  }

  Future<WeatherModel?> getWeatherByCoordinates(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'weather',
        queryParameters: {'lat': lat, 'lon': lon},
      );
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      print('Koordinat ile hava durumu alınırken hata: $e');
    }
    return null;
  }

  /// Get location info (name, state, country) by query (e.g. "Alanya")
  Future<LocationInfo?> getLocationByQuery(String query) async {
    try {
      final response = await _geoDio.get(
        'direct',
        queryParameters: {'q': query, 'limit': 1},
      );
      if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
        return LocationInfo.fromJson(response.data[0]);
      }
    } catch (e) {
      print('Konum aranırken hata: $e');
    }
    return null;
  }

  /// Get location info by coordinates (Reverse Geocoding)
  Future<LocationInfo?> getLocationByCoordinates(double lat, double lon) async {
    try {
      final response = await _geoDio.get(
        'reverse',
        queryParameters: {'lat': lat, 'lon': lon, 'limit': 1},
      );
      if (response.statusCode == 200 && (response.data as List).isNotEmpty) {
        return LocationInfo.fromJson(response.data[0]);
      }
    } catch (e) {
      print('Ters geocoding hatası: $e');
    }
    return null;
  }
}
