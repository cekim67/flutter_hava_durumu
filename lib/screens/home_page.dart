import 'package:flutter/material.dart';
import 'package:flutter_hava_durumu/models/location_info.dart';
import 'package:flutter_hava_durumu/models/weather_model.dart';
import 'package:flutter_hava_durumu/services/favorites_manager.dart';
import 'package:flutter_hava_durumu/services/location_service.dart';
import 'package:flutter_hava_durumu/services/weather_service.dart';
import 'package:flutter_hava_durumu/utils/weather_helpers.dart';
import 'package:flutter_hava_durumu/widgets/app_drawer.dart';
import 'package:flutter_hava_durumu/widgets/search_dialog.dart';
import 'package:flutter_hava_durumu/widgets/weather_card.dart';
import 'package:flutter_hava_durumu/widgets/weather_details_grid.dart';

/// Main home page of the weather app with search and drawer
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  WeatherModel? _currentWeather;
  LocationInfo? _currentLocationInfo;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await FavoritesManager.initialize();
    await _loadCurrentLocation();
  }

  /// Load weather from GPS location (priority)
  Future<void> _loadCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        // 1. Get Location Info (Reverse Geocoding)
        final locationInfo = await _weatherService.getLocationByCoordinates(
          position.latitude,
          position.longitude,
        );
        
        // 2. Get Weather Data
        final weather = await _weatherService.getWeatherByCoordinates(
          position.latitude,
          position.longitude,
        );

        if (weather != null && mounted) {
          setState(() {
            _currentWeather = weather;
            _currentLocationInfo = locationInfo;
            _isLoading = false;
          });
        } else {
          _handleError('Hava durumu bilgisi alınamadı.');
        }
      } else {
        _handleError('Konum alınamadı. Lütfen konum servislerini açın.');
      }
    } catch (e) {
      _handleError('Bir hata oluştu: $e');
    }
  }

  /// Search weather by city or district name
  Future<void> _searchLocation(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 1. Get Location Info (Direct Geocoding)
      final locationInfo = await _weatherService.getLocationByQuery(query);
      
      if (locationInfo != null) {
        // 2. Get Weather Data using coordinates from Geocoding
        final weather = await _weatherService.getWeatherByCoordinates(
          locationInfo.lat,
          locationInfo.lon,
        );

        if (weather != null && mounted) {
          setState(() {
            _currentWeather = weather;
            _currentLocationInfo = locationInfo;
            _isLoading = false;
          });
        } else {
           _handleError('Hava durumu verisi alınamadı.');
        }
      } else {
        _handleError('$query için sonuç bulunamadı.');
      }
    } catch (e) {
      _handleError('Arama sırasında hata oluştu.');
    }
  }

  void _handleError(String message) {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _errorMessage = message;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _refreshWeather() async {
    if (_currentLocationInfo != null) {
      // Refresh current location using coordinates
      final weather = await _weatherService.getWeatherByCoordinates(
          _currentLocationInfo!.lat,
          _currentLocationInfo!.lon,
      );
      if (weather != null && mounted) {
        setState(() {
          _currentWeather = weather;
        });
      }
    } else {
      await _loadCurrentLocation();
    }
  }

  Future<void> _deleteFavorite(String city) async {
    await FavoritesManager.removeFavorite(city);
    setState(() {}); 
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$city favorilerden silindi.'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  bool get _isNight {
    final hour = DateTime.now().hour;
    return hour < 6 || hour >= 20;
  }
  
  // Format location name using LocationInfo if available
  String get _formattedLocationName {
    if (_currentLocationInfo != null) {
       return _currentLocationInfo!.formattedAddress;
    }
    
    // Fallback to WeatherModel data
    if (_currentWeather == null) return 'Bilinmeyen Konum';
    final name = _currentWeather!.name ?? '';
    final country = _currentWeather!.sys?.country;
    
    if (name.isEmpty) return 'Konum';
    if (country != null && country.isNotEmpty) {
      return '$name, $country';
    }
    return name;
  }

  /// Get city name for favorites (use simplest name)
  String get _favoriteName {
     return _currentLocationInfo?.name ?? _currentWeather?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final desc = _currentWeather?.weather?.isNotEmpty == true
        ? _currentWeather!.weather!.first.description
        : null;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      drawer: AppDrawer(
        favorites: FavoritesManager.favorites,
        onHomeTap: () {
          Navigator.pop(context);
          _loadCurrentLocation();
        },
        onSearchTap: () {
          Navigator.pop(context);
          _showSearchDialog();
        },
        onFavoriteSelected: (city) {
          Navigator.pop(context);
          _searchLocation(city);
        },
        onFavoriteDeleted: _deleteFavorite,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: WeatherBackground.getGradient(desc, isNight: _isNight),
            ),
          ),
          SafeArea(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _errorMessage != null
                    ? _buildErrorState()
                    : _currentWeather == null
                        ? _buildEmptyState()
                        : RefreshIndicator(
                            onRefresh: _refreshWeather,
                            color: Colors.blue,
                            backgroundColor: Colors.white,
                            child: _buildWeatherContent(),
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherContent() {
    final weather = _currentWeather!;
    final desc = weather.weather?.isNotEmpty == true
        ? weather.weather!.first.description
        : "";
    final temp = weather.main?.temp;
    final feelsLike = weather.main?.feelsLike;
    final humidity = weather.main?.humidity;
    final windSpeed = weather.wind?.speed;
    final alert = WeatherAlert.getAlert(desc, temp);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Şehir başlığı (Geocoding verisi ile detaylı)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _formattedLocationName,
              style: const TextStyle(
                fontSize: 28, // Uzun isimler içi biraz küçülttük
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                     offset: Offset(0, 2),
                     blurRadius: 4,
                     color: Colors.black26,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getGreeting(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 24),

          WeatherCard(
            temperature: temp,
            description: desc,
            feelsLike: feelsLike,
            weatherIcon:
                WeatherIconHelper.getWeatherIcon(desc, isNight: _isNight),
          ),

          const SizedBox(height: 16),
          _buildFavoriteButton(_favoriteName),

          const SizedBox(height: 20),

          if (weather.main?.tempMin != null && weather.main?.tempMax != null)
            _buildMinMaxTemperature(
              weather.main!.tempMin!,
              weather.main!.tempMax!,
            ),

          if (alert != null) ...[
            const SizedBox(height: 20),
            WeatherAlertCard(
              alert: alert,
              icon: WeatherAlert.getAlertIcon(desc),
            ),
          ],

          const SizedBox(height: 20),

          if (weather.sys?.sunrise != null && weather.sys?.sunset != null)
            SunTimesCard(
              sunrise: weather.sys!.sunrise,
              sunset: weather.sys!.sunset,
              timezone: weather.timezone,
            ),

          const SizedBox(height: 20),

          WeatherDetailsGrid(
            humidity: humidity,
            windSpeed: windSpeed,
            weather: weather,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(String cityName) {
    if (cityName.isEmpty) return const SizedBox.shrink();
    
    final isFavorite = FavoritesManager.isFavorite(cityName);
    
    return IconButton(
      onPressed: () async {
        await FavoritesManager.toggleFavorite(cityName);
        setState(() {}); 
        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                FavoritesManager.isFavorite(cityName)
                    ? '$cityName favorilere eklendi'
                    : '$cityName favorilerden çıkarıldı',
              ),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.white.withOpacity(0.9),
              behavior: SnackBarBehavior.floating,
              width: 300,
            ),
          );
        }
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red.shade400 : Colors.white70,
        size: 32,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.1),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  Widget _buildMinMaxTemperature(double min, double max) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_downward, color: Colors.blue.shade200, size: 20),
          const SizedBox(width: 4),
          Text(
            '${min.toStringAsFixed(0)}°',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade100,
            ),
          ),
          const SizedBox(width: 20),
          Icon(Icons.arrow_upward, color: Colors.orange.shade200, size: 20),
          const SizedBox(width: 4),
          Text(
            '${max.toStringAsFixed(0)}°',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.orange.shade100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            size: 100,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 24),
          const Text(
            'Hava durumu görüntülenemiyor',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _loadCurrentLocation,
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Dene'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.white.withOpacity(0.8),
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Bir hata oluştu',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadCurrentLocation,
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => SearchDialog(
        onSearch: _searchLocation,
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 6) return 'İyi Geceler';
    if (hour < 12) return 'Günaydın';
    if (hour < 18) return 'İyi Günler';
    return 'İyi Akşamlar';
  }
}
