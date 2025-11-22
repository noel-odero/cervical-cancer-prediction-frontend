class PredictionRequest {
  final int numberOfSexualPartners;
  final int firstSexualIntercourse;
  final int smokes; // 0 or 1
  final int hormonalContraceptives; // 0 or 1
  final int iudYears; // 0-20
  final int stds; // 0 or 1
  final int stdsNumber; // 0-10
  final int stdsCervicalCondylomatosis; // 0 or 1
  final int stdsPelvicInflammatoryDisease; // 0 or 1
  final int stdsGenitalHerpes; // 0 or 1

  PredictionRequest({
    required this.numberOfSexualPartners,
    required this.firstSexualIntercourse,
    required this.smokes,
    required this.hormonalContraceptives,
    required this.iudYears,
    required this.stds,
    required this.stdsNumber,
    required this.stdsCervicalCondylomatosis,
    required this.stdsPelvicInflammatoryDisease,
    required this.stdsGenitalHerpes,
  });

  Map<String, dynamic> toJson() {
    return {
      "Number of sexual partners": numberOfSexualPartners,
      "First sexual intercourse": firstSexualIntercourse,
      "Smokes": smokes,
      "Hormonal Contraceptives": hormonalContraceptives,
      "IUD (years)": iudYears,
      "STDs": stds,
      "STDs (number)": stdsNumber,
      "STDs:cervical condylomatosis": stdsCervicalCondylomatosis,
      "STDs:pelvic inflammatory disease": stdsPelvicInflammatoryDisease,
      "STDs:genital herpes": stdsGenitalHerpes,
    };
  }

  factory PredictionRequest.fromMap(Map<String, dynamic> data) {
    return PredictionRequest(
      numberOfSexualPartners: data['Number of sexual partners'] ?? 0,
      firstSexualIntercourse: data['First sexual intercourse'] ?? 0,
      smokes: data['Smokes'] ?? 0,
      hormonalContraceptives: data['Hormonal Contraceptives'] ?? 0,
      iudYears: data['IUD (years)'] ?? 0,
      stds: data['STDs'] ?? 0,
      stdsNumber: data['STDs (number)'] ?? 0,
      stdsCervicalCondylomatosis: data['STDs:cervical condylomatosis'] ?? 0,
      stdsPelvicInflammatoryDisease:
          data['STDs:pelvic inflammatory disease'] ?? 0,
      stdsGenitalHerpes: data['STDs:genital herpes'] ?? 0,
    );
  }
}
