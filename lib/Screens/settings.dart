// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: Text('Section 1'),
            tiles: [
              SettingsTile(
                title: Text('Language'),
                description: Text('English'),
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {
                  // Add your language change logic here
                },
              ),
              SettingsTile.switchTile(
                title: Text('Use System Theme'),
                leading: Icon(Icons.phone_android),
                initialValue: isSwitched,
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            title: Text('Section 2'),
            tiles: [
              SettingsTile(
                title: Text('Security'),
                description: Text('Fingerprint'),
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {
                  // Add your security settings logic here
                },
              ),
              SettingsTile.switchTile(
                title: Text('Use fingerprint'),
                leading: Icon(Icons.fingerprint),
                initialValue: true,
                onToggle: (value) {
                  // Add fingerprint enable/disable logic here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
