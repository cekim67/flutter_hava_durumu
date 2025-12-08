/// Model representing a district (ilçe) within a city
class DistrictModel {
  final String name;
  final String cityPlateCode;
  final double latitude;
  final double longitude;

  const DistrictModel({
    required this.name,
    required this.cityPlateCode,
    required this.latitude,
    required this.longitude,
  });
}
