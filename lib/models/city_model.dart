/// Model representing a city in Turkey
class CityModel {
  final String name;
  final String plateCode;
  final String region;
  final bool hasDistricts;

  const CityModel({
    required this.name,
    required this.plateCode,
    required this.region,
    this.hasDistricts = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityModel &&
          runtimeType == other.runtimeType &&
          plateCode == other.plateCode;

  @override
  int get hashCode => plateCode.hashCode;
}
