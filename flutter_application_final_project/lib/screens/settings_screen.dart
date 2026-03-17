import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/sidebar.dart';
import '../widgets/top_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedMenuIndex = 4; // Settings is at index 4

  // State variables for the switches
  bool _pushNotifications = true;
  bool _emailAlerts = false;
  bool _criticalSiren = true;

  void _onMenuItemSelected(int index) {
    if (index == _selectedMenuIndex) return;

    setState(() {
      _selectedMenuIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/history');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/relatives');
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      // Handle mobile drawer if needed
      drawer: !isDesktop ? Drawer(
        child: Sidebar(
          selectedIndex: _selectedMenuIndex,
          onItemSelected: _onMenuItemSelected,
        ),
      ) : null,
      body: Row(
        children: [
          if (isDesktop)
            Sidebar(
              selectedIndex: _selectedMenuIndex,
              onItemSelected: _onMenuItemSelected,
            ),
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Application Settings',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        _buildSettingsCard(
                          title: "Notification Settings",
                          children: [
                            _buildToggleTile(
                              "Push Notifications", 
                              _pushNotifications, 
                              (val) => setState(() => _pushNotifications = val),
                            ),
                            _buildToggleTile(
                              "Email Alerts", 
                              _emailAlerts, 
                              (val) => setState(() => _emailAlerts = val),
                            ),
                            _buildToggleTile(
                              "Critical Emergency Siren", 
                              _criticalSiren, 
                              (val) => setState(() => _criticalSiren = val),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        _buildSettingsCard(
                          title: "Device Calibration",
                          children: [
                            ListTile(
                              title: const Text("Sensor Sensitivity"),
                              subtitle: const Text("Adjust fall detection threshold"),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                // Add logic for sensitivity adjustment here
                              },
                            ),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ListTile(
                              title: const Text("Re-calibrate Gyroscope"),
                              subtitle: const Text("Last calibrated: 2 days ago"),
                              trailing: TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Calibration started...")),
                                  );
                                },
                                child: const Text("Start"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold, 
              color: AppColors.textMedium,
              fontSize: 13,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildToggleTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(
        title, 
        style: const TextStyle(fontSize: 14, color: AppColors.textDark),
      ),
      value: value,
      activeColor: AppColors.primary,
      onChanged: onChanged, // Now correctly calls setState from the parent
    );
  }
}