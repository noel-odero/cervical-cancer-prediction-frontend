import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Logo/Icon
              Icon(Icons.favorite, size: 80, color: AppTheme.primaryPink),
              const SizedBox(height: 32),

              // App Title
              Text(
                'CERVICAL CANCER PREDICTION',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.primaryPink,
                  letterSpacing: 2,
                  fontSize: 36,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Cervical Cancer Risk Prediction',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textGrey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Description Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Empowering women with tools for early detection and better outcomes.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Features
                      _buildFeatureItem(
                        context,
                        Icons.check_circle,
                        'Quick Assessment',
                      ),
                      const SizedBox(height: 10),
                      _buildFeatureItem(context, Icons.security, 'AI-Powered'),
                      const SizedBox(height: 10),
                      _buildFeatureItem(
                        context,
                        Icons.medical_services,
                        'Personalized Results',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/input');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Get Started'),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Disclaimer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'For informational purposes only. Not a substitute for medical advice.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryPink, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.textWhite),
          ),
        ),
      ],
    );
  }
}
