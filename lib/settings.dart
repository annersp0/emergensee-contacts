// settings.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static const double fontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 132, 9, 9),
            title: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: themeProvider.currentTheme == ThemeData.dark()
                          ? Colors.white
                          : Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  trailing: Switch(
                    value: themeProvider.currentTheme == ThemeData.dark(),
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Icon(
              Icons.logout,
              color: themeProvider.currentTheme == ThemeData.dark()
                  ? Colors.white
                  : null,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            disabledElevation: 0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
}
