import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo/Icon
              Icon(Icons.favorite, size: 100, color: AppTheme.primaryPink),
              const SizedBox(height: 40),

              // App Title
              Text(
                'CERVICAL CANCER PREDICTION',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.primaryPink,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Cervical Cancer Risk Prediction',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppTheme.textGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Description Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Empowering women with an app to detect cervical cancer risk early.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.6),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Features
                      _buildFeatureItem(
                        context,
                        Icons.check_circle,
                        'Quick & Easy Assessment',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        context,
                        Icons.security,
                        'AI-Powered Prediction',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        context,
                        Icons.medical_services,
                        'Personalized Recommendations',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/input');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Get Started'),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Disclaimer
              Text(
                'This tool is for informational purposes only and does not replace professional medical advice.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
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
