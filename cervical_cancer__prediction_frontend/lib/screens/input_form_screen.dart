import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../models/prediction_request.dart';
import '../services/api_service.dart';
import 'results_screen.dart';

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key});

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  bool _isLoading = false;
  bool _isFormValid = false;
  // Controllers for numeric fields
  final TextEditingController _partnersController = TextEditingController();
  final TextEditingController _firstSexController = TextEditingController();
  final TextEditingController _iudController = TextEditingController();
  final TextEditingController _stdsNumberController = TextEditingController();

  // Binary fields as switches (bool -> int mapping when building payload)
  bool _smokes = false;
  bool _hormonalContraceptives = false;
  bool _stds = false;
  bool _stdsCervicalCondylomatosis = false;
  bool _stdsPelvicInflammatoryDisease = false;
  bool _stdsGenitalHerpes = false;

  @override
  void dispose() {
    _partnersController.dispose();
    _firstSexController.dispose();
    _iudController.dispose();
    _stdsNumberController.dispose();
    super.dispose();
  }

  String? _validateRange(String? value, String fieldName, int min, int max) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid number';
    }
    if (intValue < min || intValue > max) {
      return 'Value must be between $min and $max';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = PredictionRequest(
        numberOfSexualPartners: int.parse(_partnersController.text),
        firstSexualIntercourse: int.parse(_firstSexController.text),
        smokes: _smokes ? 1 : 0,
        hormonalContraceptives: _hormonalContraceptives ? 1 : 0,
        iudYears: int.parse(_iudController.text),
        stds: _stds ? 1 : 0,
        stdsNumber: int.parse(_stdsNumberController.text),
        stdsCervicalCondylomatosis: _stdsCervicalCondylomatosis ? 1 : 0,
        stdsPelvicInflammatoryDisease: _stdsPelvicInflammatoryDisease ? 1 : 0,
        stdsGenitalHerpes: _stdsGenitalHerpes ? 1 : 0,
      );

      final response = await _apiService.predictRisk(request);

      if (!mounted) return;

      // Navigate to results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(response: response),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppTheme.dangerRed,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Assessment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppTheme.primaryPink),
                  const SizedBox(height: 16),
                  Text(
                    'Analyzing your data...',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () {
                  final valid = _formKey.currentState?.validate() ?? false;
                  if (valid != _isFormValid) {
                    setState(() {
                      _isFormValid = valid;
                    });
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Text(
                      'Please fill in all fields',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Use switches for Yes/No fields and enter integers for numeric fields',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Field 1: Number of sexual partners (0-50)
                    _buildTextField(
                      controller: _partnersController,
                      label: 'Number of sexual partners',
                      hint: 'Enter 0-50',
                      validator: (value) => _validateRange(
                        value,
                        'Number of sexual partners',
                        0,
                        50,
                      ),
                      icon: Icons.group,
                    ),
                    const SizedBox(height: 16),

                    // Field 2: First sexual intercourse (age 10-30)
                    _buildTextField(
                      controller: _firstSexController,
                      label: 'First sexual intercourse',
                      hint: 'Enter age (10-30)',
                      validator: (value) => _validateRange(
                        value,
                        'First sexual intercourse',
                        10,
                        30,
                      ),
                      icon: Icons.cake,
                    ),
                    const SizedBox(height: 16),

                    // Field 3: Smokes (Yes/No)
                    SwitchListTile(
                      title: const Text('Smokes'),
                      value: _smokes,
                      onChanged: (v) => setState(() => _smokes = v),
                      secondary: Icon(
                        Icons.smoking_rooms,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Field 4: Hormonal Contraceptives (Yes/No)
                    SwitchListTile(
                      title: const Text('Hormonal Contraceptives'),
                      value: _hormonalContraceptives,
                      onChanged: (v) =>
                          setState(() => _hormonalContraceptives = v),
                      secondary: Icon(
                        Icons.medical_services,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Field 5: IUD (years) 0-20
                    _buildTextField(
                      controller: _iudController,
                      label: 'IUD (years)',
                      hint: 'Enter 0-20',
                      validator: (value) =>
                          _validateRange(value, 'IUD (years)', 0, 20),
                      icon: Icons.timeline,
                    ),
                    const SizedBox(height: 16),

                    // Field 6: STDs (Yes/No)
                    SwitchListTile(
                      title: const Text('STDs'),
                      value: _stds,
                      onChanged: (v) => setState(() => _stds = v),
                      secondary: Icon(
                        Icons.warning,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Field 7: STDs (number) 0-10
                    _buildTextField(
                      controller: _stdsNumberController,
                      label: 'STDs (number)',
                      hint: 'Enter 0-10',
                      validator: (value) =>
                          _validateRange(value, 'STDs (number)', 0, 10),
                      icon: Icons.format_list_numbered,
                    ),
                    const SizedBox(height: 16),

                    // Field 8: STDs:cervical condylomatosis (Yes/No)
                    SwitchListTile(
                      title: const Text('STDs:cervical condylomatosis'),
                      value: _stdsCervicalCondylomatosis,
                      onChanged: (v) =>
                          setState(() => _stdsCervicalCondylomatosis = v),
                      secondary: Icon(
                        Icons.healing,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Field 9: STDs:pelvic inflammatory disease (Yes/No)
                    SwitchListTile(
                      title: const Text('STDs:pelvic inflammatory disease'),
                      value: _stdsPelvicInflammatoryDisease,
                      onChanged: (v) =>
                          setState(() => _stdsPelvicInflammatoryDisease = v),
                      secondary: Icon(
                        Icons.local_hospital,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Field 10: STDs:genital herpes (Yes/No)
                    SwitchListTile(
                      title: const Text('STDs:genital herpes'),
                      value: _stdsGenitalHerpes,
                      onChanged: (v) => setState(() => _stdsGenitalHerpes = v),
                      secondary: Icon(
                        Icons.coronavirus,
                        color: AppTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    ElevatedButton(
                      onPressed: (!_isLoading && _isFormValid)
                          ? _submitForm
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text('Predict Risk'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?) validator,
    required IconData icon,
    String? helperText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        prefixIcon: Icon(icon, color: AppTheme.primaryPink),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: validator,
    );
  }
}
