import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onSearchTap;
  final List<String> favorites;
  final Function(String) onFavoriteSelected;
  final Function(String) onFavoriteDeleted;

  const AppDrawer({
    super.key,
    required this.onHomeTap,
    required this.onSearchTap,
    required this.favorites,
    required this.onFavoriteSelected,
    required this.onFavoriteDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade600],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.cloud_circle_outlined,
                      size: 64,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Hava Durumu',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Türkiye Geneli',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white24),
              _buildListTile(
                icon: Icons.my_location,
                title: 'Konumum (GPS)',
                onTap: onHomeTap,
              ),
              _buildListTile(
                icon: Icons.search,
                title: 'Konum Ara',
                onTap: onSearchTap,
              ),
              
              const SizedBox(height: 16),
              if (favorites.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    'FAVORİLER',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final city = favorites[index];
                      return Dismissible(
                        key: Key(city),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => onFavoriteDeleted(city),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          color: Colors.red.withOpacity(0.8),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.place, color: Colors.white70, size: 20),
                          title: Text(
                            city,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white30, size: 18),
                            onPressed: () => onFavoriteDeleted(city),
                          ),
                          onTap: () => onFavoriteSelected(city),
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else
                const Spacer(),
                
              const Divider(color: Colors.white24),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'v1.2.0',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
