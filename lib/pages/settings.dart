import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Settings"),
        actions: [
          PopupMenuButton(
            onSelected: (String value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
              PopupMenuItem(
                value: "About",
                child: IconButton(
                  onPressed: () {
                    //sign out the user
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      //Drawer
      drawer: MyDrawer(),

      //Body
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
            tiles: <SettingsTile>[
              SettingsTile.switchTile(
                onToggle: (value) {},
                leading: const Icon(Icons.notifications_active),
                title: const Text('Notifications'),
                initialValue: false,
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                leading: const Icon(Icons.speaker_notes),
                title: const Text('Sound'),
                initialValue: true,
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                leading: const Icon(Icons.vibration),
                title: const Text('Vibration'),
                initialValue: true,
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                leading: const Icon(Icons.airplanemode_active),
                title: const Text('Airplane Mode'),
                initialValue: false,
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Account',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                leading: const Icon(Icons.phone),
                title: const Text('Phone'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onPressed: (BuildContext context) {
                  //logout the user
                  logout();
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Security',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                leading: const Icon(Icons.fingerprint),
                title: const Text('Enable fingerprint'),
                initialValue: false,
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                leading: const Icon(Icons.lock),
                title: const Text('Lock app in background'),
                initialValue: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
