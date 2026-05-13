import 'package:flutter/material.dart';

/// Entry point settings page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _SettingsTile(
            icon: Icons.palette,
            title: 'Aussehen',
            subtitle: 'Theme, Farben, Glassmorphism',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AppearanceSettingsPage()),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.notifications,
            title: 'Benachrichtigungen',
            subtitle: 'Push & Sounds',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationSettingsPage()),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.tune,
            title: 'Allgemein',
            subtitle: 'Einheiten, Verhalten',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GeneralSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Reusable tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

/// Appearance / Look settings page
class AppearanceSettingsPage extends StatefulWidget {
  const AppearanceSettingsPage({super.key});

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  bool glassmorphism = true;
  bool darkMode = true;
  double blurStrength = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aussehen')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: darkMode,
            onChanged: (v) => setState(() => darkMode = v),
          ),
          SwitchListTile(
            title: const Text('Glassmorphism UI'),
            subtitle: const Text('Blur & transparente Karten'),
            value: glassmorphism,
            onChanged: (v) => setState(() => glassmorphism = v),
          ),
          const SizedBox(height: 12),
          Text('Blur Stärke: ${blurStrength.toInt()}'),
          Slider(
            value: blurStrength,
            min: 0,
            max: 25,
            onChanged: (v) => setState(() => blurStrength = v),
          ),
        ],
      ),
    );
  }
}

/// Notifications settings
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool pushEnabled = true;
  bool soundEnabled = true;
  bool hapticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benachrichtigungen')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: pushEnabled,
            onChanged: (v) => setState(() => pushEnabled = v),
          ),
          SwitchListTile(
            title: const Text('Sound Feedback'),
            value: soundEnabled,
            onChanged: (v) => setState(() => soundEnabled = v),
          ),
          SwitchListTile(
            title: const Text('Haptic Feedback'),
            value: hapticsEnabled,
            onChanged: (v) => setState(() => hapticsEnabled = v),
          ),
        ],
      ),
    );
  }
}

/// General settings placeholder
class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Allgemein')),
      body: const Center(
        child: Text('Weitere Einstellungen kommen hier rein'),
      ),
    );
  }
}
