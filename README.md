# Cervical Cancer Risk Prediction App

A Flutter mobile application for predicting cervical cancer risk using AI-powered analysis. This app connects to a FastAPI backend to provide personalized risk assessments and recommendations.


![Platform](https://img.shields.io/badge/Platform-Flutter-02569B)
![API](https://img.shields.io/badge/API-FastAPI-009688)

## Features

- **Smart Input Form** - 10 validated input fields with real-time validation
- **AI-Powered Prediction** - Machine learning model for risk assessment
- **Visual Results** - Color-coded risk levels with detailed recommendations
- **Fast & Responsive** - Optimized for smooth user experience
- **Secure** - HTTPS API communication

| Screen | Content | Image |
|--------|--------|--------|
| Welcome Screen | - App introduction and mission statement - Feature highlights - Get Started button | <img width="392" height="797" alt="image" src="https://github.com/user-attachments/assets/4c4809eb-7da6-4ad4-aafb-539bf6bb1729" />|
| Input Form screen | - 10 medical input fields with validation - Helper text for each field - Loading indicator during prediction | <img width="381" height="802" alt="image" src="https://github.com/user-attachments/assets/1d284f27-69af-4eb6-b5e8-ab30efe88e53" />|
| Result screen | - Risk score percentage - Risk level (color-coded) - Personalized recommendation - Option to start a new prediction | <img width="396" height="801" alt="image" src="https://github.com/user-attachments/assets/82c66341-83a9-4f40-8521-e12fd68a40d6" />|


## Project Structure

```
lib/
├── main.dart                    # App entry point with routing
├── theme/
│   └── app_theme.dart          # Custom theme with color palette
├── models/
│   ├── prediction_request.dart  # Request data model
│   └── prediction_response.dart # Response data model
├── services/
│   └── api_service.dart        # API communication service
└── screens/
    ├── welcome_screen.dart     # Home/Welcome screen
    ├── input_form_screen.dart  # Input form with validation
    └── results_screen.dart     # Results display screen
```

## API Integration

**Base URL:** `https://cervical-cancer-prediction.onrender.com`

**Endpoint:** `POST /predict`

### Input Fields (10 total)

1. **STDs** - 0 or 1
2. **STDs (number)** - 0-20
3. **STDs: Condylomatosis** - 0 or 1
4. **STDs: Vulvo-perineal Condylomatosis** - 0 or 1
5. **STDs: HIV** - 0 or 1
6. **STDs: Number of Diagnosis** - 0-10
7. **Dx: Cancer** - 0 or 1
8. **Dx: HPV** - 0 or 1
9. **Dx** - 0 or 1
10. **Citology** - 0 or 1

### Response Format

```json
{
  "risk_score": 0.8,
  "risk_level": "VERY HIGH",
  "recommendation": "Immediate medical intervention required",
  "model_used": "DecisionTreeRegressor"
}
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. Clone the repository:
```bash
cd cervical_cancer__prediction_frontend
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0
```

## Color Palette

The app uses a carefully selected color scheme

- **Primary Pink:** `#FF0080` - Main brand color
- **Dark Background:** `#0A0A1F` - Deep navy background
- **Card Background:** `#1A1A3E` - Elevated surfaces
- **Accent Pink:** `#FF1493` - Interactive elements
- **Text White:** `#FFFFFF` - Primary text
- **Text Grey:** `#B0B0C8` - Secondary text

### Risk Level Colors

- **Low Risk:** Green (`#4CAF50`)
- **Medium Risk:** Orange (`#FF9800`)
- **High Risk:** Red (`#FF1744`)

## Features in Detail

### Input Validation

- Binary fields accept only 0 or 1
- Range fields validate against specified min/max values
- Real-time error feedback
- Required field validation

### Error Handling

- Network error detection
- Server error handling (422, 500)
- User-friendly error messages
- Graceful degradation

### User Experience

- Loading indicators during API calls
- Smooth navigation transitions
- Clear visual hierarchy
- Accessible design patterns

## Building for Production

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## Medical Disclaimer

**Important Notice:**

This application is a predictive tool and is NOT a substitute for professional medical diagnosis. The predictions provided are based on machine learning models and should be used for informational purposes only.

**Always consult with a qualified healthcare provider for:**
- Proper medical diagnosis
- Treatment recommendations
- Medical advice and guidance

## Contributing

This is a medical application. Any contributions should be:
- Thoroughly tested
- Medically reviewed
- Privacy-compliant
- Ethically sound

## License

This project is created for educational and informational purposes.



## Acknowledgments

- FastAPI backend team
- Kaggle datasets
- Flutter community
- Open source contributors

---

**Developed with love for better women's health outcomes**


