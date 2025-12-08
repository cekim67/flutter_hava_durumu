import 'package:shared_preferences/shared_preferences.dart';

/// Manager for handling favorite cities with persistent storage
class FavoritesManager {
  static const String _favoritesKey = 'favorite_cities';
  static List<String> _favorites = [];
  static bool _isInitialized = false;

  /// Initialize favorites from persistent storage
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(_favoritesKey) ?? [];
    _isInitialized = true;
  }

  /// Get all favorites
  static List<String> get favorites => List.unmodifiable(_favorites);

  /// Add a city to favorites
  static Future<void> addFavorite(String cityName) async {
    if (!_favorites.contains(cityName)) {
      _favorites.add(cityName);
      await _saveFavorites();
    }
  }

  /// Remove a city from favorites
  static Future<void> removeFavorite(String cityName) async {
    _favorites.remove(cityName);
    await _saveFavorites();
  }

  /// Check if a city is in favorites
  static bool isFavorite(String cityName) {
    return _favorites.contains(cityName);
  }

  /// Toggle favorite status for a city
  static Future<void> toggleFavorite(String cityName) async {
    if (isFavorite(cityName)) {
      await removeFavorite(cityName);
    } else {
      await addFavorite(cityName);
    }
  }

  /// Save favorites to persistent storage
  static Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, _favorites);
  }

  /// Clear all favorites
  static Future<void> clearFavorites() async {
    _favorites.clear();
    await _saveFavorites();
  }
}
