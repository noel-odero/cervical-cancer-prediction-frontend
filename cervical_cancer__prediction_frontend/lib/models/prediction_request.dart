class PredictionRequest {
  final int stds;
  final int stdsNumber;
  final int stdsCondylomatosis;
  final int stdsVulvoPerinealCondylomatosis;
  final int stdsHiv;
  final int stdsNumberOfDiagnosis;
  final int dxCancer;
  final int dxHpv;
  final int dx;
  final int citology;

  PredictionRequest({
    required this.stds,
    required this.stdsNumber,
    required this.stdsCondylomatosis,
    required this.stdsVulvoPerinealCondylomatosis,
    required this.stdsHiv,
    required this.stdsNumberOfDiagnosis,
    required this.dxCancer,
    required this.dxHpv,
    required this.dx,
    required this.citology,
  });

  Map<String, dynamic> toJson() {
    return {
      'STDs': stds,
      'STDs (number)': stdsNumber,
      'STDs:condylomatosis': stdsCondylomatosis,
      'STDs:vulvo-perineal condylomatosis': stdsVulvoPerinealCondylomatosis,
      'STDs:HIV': stdsHiv,
      'STDs: Number of diagnosis': stdsNumberOfDiagnosis,
      'Dx:Cancer': dxCancer,
      'Dx:HPV': dxHpv,
      'Dx': dx,
      'Citology': citology,
    };
  }

  // Validation methods
  bool isValid() {
    return _validateBinary(stds) &&
        _validateRange(stdsNumber, 0, 20) &&
        _validateBinary(stdsCondylomatosis) &&
        _validateBinary(stdsVulvoPerinealCondylomatosis) &&
        _validateBinary(stdsHiv) &&
        _validateRange(stdsNumberOfDiagnosis, 0, 10) &&
        _validateBinary(dxCancer) &&
        _validateBinary(dxHpv) &&
        _validateBinary(dx) &&
        _validateBinary(citology);
  }

  bool _validateBinary(int value) {
    return value == 0 || value == 1;
  }

  bool _validateRange(int value, int min, int max) {
    return value >= min && value <= max;
  }

  factory PredictionRequest.fromMap(Map<String, int> data) {
    return PredictionRequest(
      stds: data['STDs'] ?? 0,
      stdsNumber: data['STDs (number)'] ?? 0,
      stdsCondylomatosis: data['STDs:condylomatosis'] ?? 0,
      stdsVulvoPerinealCondylomatosis: data['STDs:vulvo-perineal condylomatosis'] ?? 0,
      stdsHiv: data['STDs:HIV'] ?? 0,
      stdsNumberOfDiagnosis: data['STDs: Number of diagnosis'] ?? 0,
      dxCancer: data['Dx:Cancer'] ?? 0,
      dxHpv: data['Dx:HPV'] ?? 0,
      dx: data['Dx'] ?? 0,
      citology: data['Citology'] ?? 0,
    );
  }
}
