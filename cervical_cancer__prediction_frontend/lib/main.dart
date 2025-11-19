import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_screen.dart';
import 'screens/input_form_screen.dart';

void main() {
  runApp(const CervicalCancerPredictionApp());
}

class CervicalCancerPredictionApp extends StatelessWidget {
  const CervicalCancerPredictionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cervical Cancer Risk Prediction',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/input': (context) => const InputFormScreen(),
      },
    );
  }
}
