import 'package:flutter_hava_durumu/models/city_model.dart';

/// Static data for all 81 cities in Turkey
class TurkeyData {
  static const List<CityModel> cities = [
    CityModel(name: 'Adana', plateCode: '01', region: 'Akdeniz'),
    CityModel(name: 'Adıyaman', plateCode: '02', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Afyonkarahisar', plateCode: '03', region: 'Ege'),
    CityModel(name: 'Ağrı', plateCode: '04', region: 'Doğu Anadolu'),
    CityModel(name: 'Amasya', plateCode: '05', region: 'Karadeniz'),
    CityModel(name: 'Ankara', plateCode: '06', region: 'İç Anadolu', hasDistricts: true),
    CityModel(name: 'Antalya', plateCode: '07', region: 'Akdeniz', hasDistricts: true),
    CityModel(name: 'Artvin', plateCode: '08', region: 'Karadeniz'),
    CityModel(name: 'Aydın', plateCode: '09', region: 'Ege'),
    CityModel(name: 'Balıkesir', plateCode: '10', region: 'Marmara'),
    CityModel(name: 'Bilecik', plateCode: '11', region: 'Marmara'),
    CityModel(name: 'Bingöl', plateCode: '12', region: 'Doğu Anadolu'),
    CityModel(name: 'Bitlis', plateCode: '13', region: 'Doğu Anadolu'),
    CityModel(name: 'Bolu', plateCode: '14', region: 'Karadeniz'),
    CityModel(name: 'Burdur', plateCode: '15', region: 'Akdeniz'),
    CityModel(name: 'Bursa', plateCode: '16', region: 'Marmara', hasDistricts: true),
    CityModel(name: 'Çanakkale', plateCode: '17', region: 'Marmara'),
    CityModel(name: 'Çankırı', plateCode: '18', region: 'İç Anadolu'),
    CityModel(name: 'Çorum', plateCode: '19', region: 'Karadeniz'),
    CityModel(name: 'Denizli', plateCode: '20', region: 'Ege'),
    CityModel(name: 'Diyarbakır', plateCode: '21', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Edirne', plateCode: '22', region: 'Marmara'),
    CityModel(name: 'Elazığ', plateCode: '23', region: 'Doğu Anadolu'),
    CityModel(name: 'Erzincan', plateCode: '24', region: 'Doğu Anadolu'),
    CityModel(name: 'Erzurum', plateCode: '25', region: 'Doğu Anadolu'),
    CityModel(name: 'Eskişehir', plateCode: '26', region: 'İç Anadolu'),
    CityModel(name: 'Gaziantep', plateCode: '27', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Giresun', plateCode: '28', region: 'Karadeniz'),
    CityModel(name: 'Gümüşhane', plateCode: '29', region: 'Karadeniz'),
    CityModel(name: 'Hakkari', plateCode: '30', region: 'Doğu Anadolu'),
    CityModel(name: 'Hatay', plateCode: '31', region: 'Akdeniz'),
    CityModel(name: 'Isparta', plateCode: '32', region: 'Akdeniz'),
    CityModel(name: 'Mersin', plateCode: '33', region: 'Akdeniz'),
    CityModel(name: 'Istanbul', plateCode: '34', region: 'Marmara', hasDistricts: true),
    CityModel(name: 'Izmir', plateCode: '35', region: 'Ege', hasDistricts: true),
    CityModel(name: 'Kars', plateCode: '36', region: 'Doğu Anadolu'),
    CityModel(name: 'Kastamonu', plateCode: '37', region: 'Karadeniz'),
    CityModel(name: 'Kayseri', plateCode: '38', region: 'İç Anadolu'),
    CityModel(name: 'Kırklareli', plateCode: '39', region: 'Marmara'),
    CityModel(name: 'Kırşehir', plateCode: '40', region: 'İç Anadolu'),
    CityModel(name: 'Kocaeli', plateCode: '41', region: 'Marmara'),
    CityModel(name: 'Konya', plateCode: '42', region: 'İç Anadolu'),
    CityModel(name: 'Kütahya', plateCode: '43', region: 'Ege'),
    CityModel(name: 'Malatya', plateCode: '44', region: 'Doğu Anadolu'),
    CityModel(name: 'Manisa', plateCode: '45', region: 'Ege'),
    CityModel(name: 'Kahramanmaraş', plateCode: '46', region: 'Akdeniz'),
    CityModel(name: 'Mardin', plateCode: '47', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Muğla', plateCode: '48', region: 'Ege'),
    CityModel(name: 'Muş', plateCode: '49', region: 'Doğu Anadolu'),
    CityModel(name: 'Nevşehir', plateCode: '50', region: 'İç Anadolu'),
    CityModel(name: 'Niğde', plateCode: '51', region: 'İç Anadolu'),
    CityModel(name: 'Ordu', plateCode: '52', region: 'Karadeniz'),
    CityModel(name: 'Rize', plateCode: '53', region: 'Karadeniz'),
    CityModel(name: 'Sakarya', plateCode: '54', region: 'Marmara'),
    CityModel(name: 'Samsun', plateCode: '55', region: 'Karadeniz'),
    CityModel(name: 'Siirt', plateCode: '56', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Sinop', plateCode: '57', region: 'Karadeniz'),
    CityModel(name: 'Sivas', plateCode: '58', region: 'İç Anadolu'),
    CityModel(name: 'Tekirdağ', plateCode: '59', region: 'Marmara'),
    CityModel(name: 'Tokat', plateCode: '60', region: 'Karadeniz'),
    CityModel(name: 'Trabzon', plateCode: '61', region: 'Karadeniz'),
    CityModel(name: 'Tunceli', plateCode: '62', region: 'Doğu Anadolu'),
    CityModel(name: 'Şanlıurfa', plateCode: '63', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Uşak', plateCode: '64', region: 'Ege'),
    CityModel(name: 'Van', plateCode: '65', region: 'Doğu Anadolu'),
    CityModel(name: 'Yozgat', plateCode: '66', region: 'İç Anadolu'),
    CityModel(name: 'Zonguldak', plateCode: '67', region: 'Karadeniz'),
    CityModel(name: 'Aksaray', plateCode: '68', region: 'İç Anadolu'),
    CityModel(name: 'Bayburt', plateCode: '69', region: 'Karadeniz'),
    CityModel(name: 'Karaman', plateCode: '70', region: 'İç Anadolu'),
    CityModel(name: 'Kırıkkale', plateCode: '71', region: 'İç Anadolu'),
    CityModel(name: 'Batman', plateCode: '72', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Şırnak', plateCode: '73', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Bartın', plateCode: '74', region: 'Karadeniz'),
    CityModel(name: 'Ardahan', plateCode: '75', region: 'Doğu Anadolu'),
    CityModel(name: 'Iğdır', plateCode: '76', region: 'Doğu Anadolu'),
    CityModel(name: 'Yalova', plateCode: '77', region: 'Marmara'),
    CityModel(name: 'Karabük', plateCode: '78', region: 'Karadeniz'),
    CityModel(name: 'Kilis', plateCode: '79', region: 'Güneydoğu Anadolu'),
    CityModel(name: 'Osmaniye', plateCode: '80', region: 'Akdeniz'),
    CityModel(name: 'Düzce', plateCode: '81', region: 'Karadeniz'),
  ];

  /// Find a city by name
  static CityModel? findByName(String name) {
    try {
      return cities.firstWhere(
        (c) => c.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Find a city by plate code
  static CityModel? findByPlateCode(String plateCode) {
    try {
      return cities.firstWhere((c) => c.plateCode == plateCode);
    } catch (_) {
      return null;
    }
  }
}
