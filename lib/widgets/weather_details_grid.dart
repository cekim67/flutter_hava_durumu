import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/models/weather_model.dart';

/// Grid widget displaying weather details (humidity, wind, pressure, visibility)
class WeatherDetailsGrid extends StatelessWidget {
  final int? humidity;
  final double? windSpeed;
  final WeatherModel weather;

  const WeatherDetailsGrid({
    super.key,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.water_drop_outlined,
                  label: 'Nem',
                  value: '%$humidity',
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.air,
                  label: 'Rüzgar',
                  value: '${windSpeed?.toStringAsFixed(1)} m/s',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(height: 1, color: Colors.white.withOpacity(0.3)),
          ),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.compress,
                  label: 'Basınç',
                  value: '${weather.main?.pressure} hPa',
                ),
              ),
              Container(
                width: 1,
                height: 60,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _buildDetailItem(
                  icon: Icons.visibility_outlined,
                  label: 'Görüş',
                  value: weather.visibility != null
                      ? '${(weather.visibility! / 1000).toStringAsFixed(1)} km'
                      : 'N/A',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }
}

/// Widget showing sunrise and sunset times
class SunTimesCard extends StatelessWidget {
  final int? sunrise;
  final int? sunset;
  final int? timezone;

  const SunTimesCard({
    super.key,
    required this.sunrise,
    required this.sunset,
    this.timezone,
  });

  String _formatTime(int? timestamp) {
    if (timestamp == null) return '--:--';
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    ).add(Duration(seconds: timezone ?? 0));
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.wb_sunny,
                  color: Colors.orange.shade300,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  _formatTime(sunrise),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Gün Doğumu',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.nightlight_round,
                  color: Colors.purple.shade200,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  _formatTime(sunset),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Gün Batımı',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
