import 'package:customer/const.dart';
import 'package:customer/ui/main/history_screen/history_screen.dart';
import 'package:customer/ui/main/home_screen/home_screen.dart';
import 'package:customer/ui/main/map_screen/map_screen.dart';
import 'package:customer/ui/main/notification_screen/notification_screen.dart';
import 'package:customer/ui/main/profile_screen/profile_screen.dart';
import 'package:customer/ui/main/qr_screen/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    MapScreen(),
    QRScreen(),
    //HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LineIcons.bell),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  const NotificationScreen(),),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor.withOpacity(.5),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.map,
                  text: 'Map',
                ),
                GButton(
                  icon: LineIcons.qrcode,
                  text: 'QR',
                ),
                //GButton(
                //  icon: LineIcons.history,
                //  text: 'History',
                //),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
