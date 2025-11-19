class PredictionResponse {
  final double riskScore;
  final String riskLevel;
  final String recommendation;
  final String modelUsed;

  PredictionResponse({
    required this.riskScore,
    required this.riskLevel,
    required this.recommendation,
    required this.modelUsed,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      riskScore: (json['risk_score'] as num).toDouble(),
      riskLevel: json['risk_level'] as String,
      recommendation: json['recommendation'] as String,
      modelUsed: json['model_used'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'risk_score': riskScore,
      'risk_level': riskLevel,
      'recommendation': recommendation,
      'model_used': modelUsed,
    };
  }

  // Get risk percentage
  String getRiskPercentage() {
    return '${(riskScore * 100).toStringAsFixed(1)}%';
  }

  // Check if risk is high
  bool isHighRisk() {
    return riskLevel.toUpperCase().contains('HIGH');
  }
}
