# Quick Start Guide

## Running the App

1. **Navigate to project directory:**
   ```bash
   cd cervical_cancer__prediction_frontend
   ```

2. **Install dependencies (already done):**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## App Flow

1. **Welcome Screen** (`/`)
   - Shows app introduction
   - "Get Started" button → navigates to input form

2. **Input Form Screen** (`/input`)
   - 10 input fields with validation
   - "Predict Risk" button → calls API and shows results

3. **Results Screen** (programmatic navigation)
   - Displays risk score, level, and recommendations
   - "New Prediction" button → returns to welcome screen

## Testing the App

### Sample Input Data (Low Risk)
- All fields: `0`

### Sample Input Data (Moderate Risk)
- STDs: `0`
- STDs (number): `2`
- STDs:condylomatosis: `0`
- STDs:vulvo-perineal condylomatosis: `0`
- STDs:HIV: `0`
- STDs: Number of diagnosis: `1`
- Dx:Cancer: `0`
- Dx:HPV: `0`
- Dx: `0`
- Citology: `0`

### Sample Input Data (High Risk)
- STDs: `1`
- STDs (number): `10`
- STDs:condylomatosis: `1`
- STDs:vulvo-perineal condylomatosis: `1`
- STDs:HIV: `1`
- STDs: Number of diagnosis: `5`
- Dx:Cancer: `1`
- Dx:HPV: `1`
- Dx: `1`
- Citology: `1`

## Troubleshooting

### No device connected
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Build errors
```bash
# Clean build files
flutter clean

# Get dependencies
flutter pub get

# Run again
flutter run
```

### Network errors
- Ensure device/emulator has internet connection
- Check if API is accessible: https://cervical-cancer-prediction.onrender.com

## Project Features Implemented

✅ Custom dark theme with pink/magenta colors from screenshot
✅ Welcome screen with app description
✅ Input form with 10 validated fields
✅ Real-time form validation
✅ Loading indicator during API call
✅ API integration with FastAPI backend
✅ Results screen with color-coded risk levels
✅ Error handling for network issues
✅ Navigation between screens
✅ Clean, modular code structure
✅ Comprehensive documentation

## File Overview

- **main.dart** - App initialization and routing
- **theme/app_theme.dart** - Color palette and theme configuration
- **models/prediction_request.dart** - Request data structure
- **models/prediction_response.dart** - Response data structure
- **services/api_service.dart** - API communication logic
- **screens/welcome_screen.dart** - Home/landing page
- **screens/input_form_screen.dart** - Data input form
- **screens/results_screen.dart** - Prediction results display

## Next Steps

1. Test the app on a real device or emulator
2. Customize colors if needed in `theme/app_theme.dart`
3. Add additional features (history, export results, etc.)
4. Deploy to app stores when ready
