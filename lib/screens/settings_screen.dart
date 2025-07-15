import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: TextStyle(
              color: Color(0xFF131712),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF131712)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Appearance'),
          _buildListTile('Theme', 'System Default'),
          _buildSectionHeader('Data Management'),
          _buildListTile('Backup Data', 'Download', icon: Icons.download),
          _buildListTile('Restore Data', 'Upload', icon: Icons.upload),
          _buildSectionHeader('About'),
          _buildListTile('Rate on App Store', 'Star', icon: Icons.star),
          _buildListTile('Share App', 'Share', icon: Icons.share),
          _buildListTile('Privacy Policy', 'Shield', icon: Icons.security),
        ],
      ),
      // Bottom navigation is provided by MainNavigationScreen
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF131712),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, {IconData? icon}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF131712),
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Color(0xFF131712),
          fontSize: 14,
        ),
      ),
      trailing: icon != null ? Icon(icon, color: Color(0xFF131712)) : null,
    );
  }
}
