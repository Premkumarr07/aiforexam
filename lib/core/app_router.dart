import 'package:flutter/material.dart';
import '../features/home/home_screen.dart';
import '../features/practice/practice_screen.dart';
import '../features/analysis/analysis_screen.dart';
import '../features/doubt_solver/chat_screen.dart';
import '../features/profile/profile_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/practice':
        return MaterialPageRoute(builder: (_) => const PracticeScreen());
      case '/analysis':
        return MaterialPageRoute(builder: (_) => const AnalysisScreen());
      case '/chat':
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
