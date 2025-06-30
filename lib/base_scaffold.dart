import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final PreferredSizeWidget? appBar; // ✅ Add appBar parameter

  const BaseScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    this.appBar, // ✅ Accept appBar as optional
  });

  void _onTabTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/practice');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/analysis');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/chat');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar, // ✅ Inject appBar into Scaffold
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTabTap(context, index),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Practice'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analysis'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'AI Help'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
