import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/widgets/animations/rain_drop.dart';
import 'package:flutter_hava_durumu/widgets/animations/snow_flake.dart';

/// Helper class for weather-based gradients and backgrounds
class WeatherBackground {
  /// Get gradient based on weather description
  static LinearGradient getGradient(String? desc, {bool isNight = false}) {
    if (desc == null) {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue.shade300, Colors.blue.shade600],
      );
    }

    desc = desc.toLowerCase();

    // Kar
    if (desc.contains("kar")) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB), Color(0xFF90CAF9)],
      );
    }

    // Yağmur
    if (desc.contains("yağmur") || desc.contains("sağanak")) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF455A64), Color(0xFF607D8B), Color(0xFF78909C)],
      );
    }

    // Fırtına
    if (desc.contains("fırtına") || desc.contains("gök gürültü")) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF263238), Color(0xFF37474F), Color(0xFF455A64)],
      );
    }

    // Bulutlu
    if (desc.contains("bulut")) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF78909C), Color(0xFF90A4AE), Color(0xFFB0BEC5)],
      );
    }

    // Güneşli/Açık
    if (desc.contains("güneş") || desc.contains("açık")) {
      if (isNight) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
        );
      }
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF42A5F5), Color(0xFF64B5F6), Color(0xFF90CAF9)],
      );
    }

    // Varsayılan
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue.shade400, Colors.blue.shade600],
    );
  }

  /// Get animated background elements based on weather
  static List<Widget> getAnimatedBackground(String? desc) {
    if (desc == null) return [];

    desc = desc.toLowerCase();

    if (desc.contains("yağmur") || desc.contains("sağanak")) {
      return List.generate(
        40,
        (index) => RainDrop(key: ValueKey('rain_$index'), index: index),
      );
    }

    if (desc.contains("kar")) {
      return List.generate(
        50,
        (index) => SnowFlake(key: ValueKey('snow_$index'), index: index),
      );
    }

    return [];
  }
}

/// Helper class for weather alerts and notifications
class WeatherAlert {
  /// Get alert message based on weather description and temperature
  static String? getAlert(String? desc, double? temp) {
    if (desc == null) return null;

    desc = desc.toLowerCase();

    if (desc.contains("kar")) {
      return "⚠️ Dikkat! Yollar buzlu ve kaygan olabilir. Dikkatli sürün!";
    }

    if (desc.contains("yağmur") || desc.contains("sağanak")) {
      return "☔ Şemsiyenizi almayı unutmayın! Yağmur bekleniyor.";
    }

    if (desc.contains("fırtına") || desc.contains("gök gürültü")) {
      return "⛈️ Fırtına uyarısı! Dışarı çıkarken dikkatli olun.";
    }

    if (temp != null && temp > 35) {
      return "🌡️ Aşırı sıcak! Bol su için ve güneşten korunun.";
    }

    if (temp != null && temp < 0) {
      return "❄️ Donma noktası altında! Kalın giyinin.";
    }

    if (desc.contains("güneş") || desc.contains("açık")) {
      return "☀️ Harika bir gün! Dışarıda vakit geçirmek için ideal.";
    }

    return null;
  }

  /// Get alert icon based on weather description
  static IconData getAlertIcon(String? desc) {
    if (desc == null) return Icons.info_outline;

    desc = desc.toLowerCase();

    if (desc.contains("kar")) return Icons.ac_unit;
    if (desc.contains("yağmur") || desc.contains("sağanak")) {
      return Icons.umbrella;
    }
    if (desc.contains("fırtına")) return Icons.warning_amber;
    if (desc.contains("güneş")) return Icons.wb_sunny;

    return Icons.info_outline;
  }
}

/// Helper class for weather icons
class WeatherIconHelper {
  /// Get weather icon based on description and time of day
  static IconData getWeatherIcon(String? desc, {bool isNight = false}) {
    if (desc == null) return Icons.help_outline;

    desc = desc.toLowerCase();

    if (desc.contains("güneş") || desc.contains("açık")) {
      return isNight ? Icons.nightlight_round : Icons.wb_sunny;
    } else if (desc.contains("parçalı") || desc.contains("az bulut")) {
      return Icons.cloud_queue;
    } else if (desc.contains("bulut")) {
      return Icons.cloud;
    } else if (desc.contains("kar")) {
      return Icons.ac_unit;
    } else if (desc.contains("yağmur") || desc.contains("sağanak")) {
      return Icons.grain;
    } else if (desc.contains("fırtına")) {
      return Icons.thunderstorm;
    }

    return Icons.wb_cloudy;
  }
}
