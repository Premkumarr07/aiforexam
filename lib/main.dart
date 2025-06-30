import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/app_router.dart';

void main() {
  runApp(const AIExamPracticeApp());
}

class AIExamPracticeApp extends StatelessWidget {
  const AIExamPracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Exam Practice',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
