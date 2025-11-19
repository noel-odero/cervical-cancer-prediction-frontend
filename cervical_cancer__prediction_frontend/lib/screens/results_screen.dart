import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/prediction_response.dart';

class ResultsScreen extends StatelessWidget {
  final PredictionResponse response;

  const ResultsScreen({Key? key, required this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riskColor = AppTheme.getRiskColor(response.riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Results'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Risk Score Card
              Card(
                elevation: 12,
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppTheme.cardBackground,
                        AppTheme.cardBackground.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(_getRiskIcon(), size: 80, color: riskColor),
                      const SizedBox(height: 24),
                      Text(
                        'Risk Score',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.textGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        response.getRiskPercentage(),
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: riskColor,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: riskColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: riskColor, width: 2),
                        ),
                        child: Text(
                          response.riskLevel,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: riskColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recommendation Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.health_and_safety,
                            color: AppTheme.primaryPink,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Recommendation',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.darkBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.textGrey.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          response.recommendation,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(height: 1.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Model Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: AppTheme.primaryPink,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Model Used',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              response.modelUsed,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Important Notice
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.warningOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.warningOrange.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.warningOrange,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'This is a predictive tool and not a substitute for professional medical diagnosis. Please consult a healthcare provider.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // New Prediction Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    const SizedBox(width: 8),
                    Text('New Prediction'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Contact Support Button
              OutlinedButton(
                onPressed: () {
                  _showContactDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.primaryPink, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.contact_support, color: AppTheme.primaryPink),
                    const SizedBox(width: 8),
                    Text(
                      'Contact Healthcare Provider',
                      style: TextStyle(
                        color: AppTheme.primaryPink,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getRiskIcon() {
    final level = response.riskLevel.toUpperCase();
    if (level.contains('VERY LOW') || level.contains('LOW')) {
      return Icons.check_circle;
    } else if (level.contains('MEDIUM') || level.contains('MODERATE')) {
      return Icons.warning;
    } else {
      return Icons.error;
    }
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.medical_services, color: AppTheme.primaryPink),
              const SizedBox(width: 12),
              Text('Get Help'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'It\'s important to consult with a healthcare professional for proper diagnosis and treatment.',
                style: TextStyle(color: AppTheme.textWhite),
              ),
              const SizedBox(height: 16),
              Text(
                'Please contact your local healthcare provider or visit a medical facility for further assistance.',
                style: TextStyle(color: AppTheme.textGrey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppTheme.primaryPink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
