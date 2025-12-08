class LocationInfo {
  final String name;
  final String? state;
  final String? country;
  final double lat;
  final double lon;

  LocationInfo({
    required this.name,
    this.state,
    this.country,
    required this.lat,
    required this.lon,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      name: json['name'] ?? '',
      state: json['state'],
      country: json['country'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );
  }

  /// Returns a formatted string like "Alanya, Antalya, TR" or "Istanbul, TR"
  String get formattedAddress {
    final List<String> parts = [name];
    if (state != null && state!.isNotEmpty && state != name) {
      parts.add(state!);
    }
    if (country != null && country!.isNotEmpty) {
      parts.add(country!);
    }
    return parts.join(', ');
  }
}
