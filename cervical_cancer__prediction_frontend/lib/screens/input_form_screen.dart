import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../models/prediction_request.dart';
import '../services/api_service.dart';
import 'results_screen.dart';

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({Key? key}) : super(key: key);

  @override
  State<InputFormScreen> createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  bool _isLoading = false;

  // Controllers for all 10 fields
  final TextEditingController _stdsController = TextEditingController();
  final TextEditingController _stdsNumberController = TextEditingController();
  final TextEditingController _stdsCondylomatosisController =
      TextEditingController();
  final TextEditingController _stdsVulvoPerinealController =
      TextEditingController();
  final TextEditingController _stdsHivController = TextEditingController();
  final TextEditingController _stdsNumDiagnosisController =
      TextEditingController();
  final TextEditingController _dxCancerController = TextEditingController();
  final TextEditingController _dxHpvController = TextEditingController();
  final TextEditingController _dxController = TextEditingController();
  final TextEditingController _citologyController = TextEditingController();

  @override
  void dispose() {
    _stdsController.dispose();
    _stdsNumberController.dispose();
    _stdsCondylomatosisController.dispose();
    _stdsVulvoPerinealController.dispose();
    _stdsHivController.dispose();
    _stdsNumDiagnosisController.dispose();
    _dxCancerController.dispose();
    _dxHpvController.dispose();
    _dxController.dispose();
    _citologyController.dispose();
    super.dispose();
  }

  String? _validateBinary(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid number';
    }
    if (intValue != 0 && intValue != 1) {
      return 'Value must be 0 or 1';
    }
    return null;
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
        stds: int.parse(_stdsController.text),
        stdsNumber: int.parse(_stdsNumberController.text),
        stdsCondylomatosis: int.parse(_stdsCondylomatosisController.text),
        stdsVulvoPerinealCondylomatosis: int.parse(
          _stdsVulvoPerinealController.text,
        ),
        stdsHiv: int.parse(_stdsHivController.text),
        stdsNumberOfDiagnosis: int.parse(_stdsNumDiagnosisController.text),
        dxCancer: int.parse(_dxCancerController.text),
        dxHpv: int.parse(_dxHpvController.text),
        dx: int.parse(_dxController.text),
        citology: int.parse(_citologyController.text),
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
                      'Enter 0 or 1 for most fields, except where noted',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Field 1: STDs
                    _buildTextField(
                      controller: _stdsController,
                      label: 'STDs',
                      hint: 'Enter 0 or 1',
                      validator: (value) => _validateBinary(value, 'STDs'),
                      icon: Icons.medical_information,
                    ),
                    const SizedBox(height: 16),

                    // Field 2: STDs (number)
                    _buildTextField(
                      controller: _stdsNumberController,
                      label: 'STDs (number)',
                      hint: 'Enter 0-20',
                      validator: (value) =>
                          _validateRange(value, 'STDs number', 0, 20),
                      icon: Icons.numbers,
                      helperText: 'Value between 0 and 20',
                    ),
                    const SizedBox(height: 16),

                    // Field 3: STDs:condylomatosis
                    _buildTextField(
                      controller: _stdsCondylomatosisController,
                      label: 'STDs: Condylomatosis',
                      hint: 'Enter 0 or 1',
                      validator: (value) =>
                          _validateBinary(value, 'Condylomatosis'),
                      icon: Icons.medical_information,
                    ),
                    const SizedBox(height: 16),

                    // Field 4: STDs:vulvo-perineal condylomatosis
                    _buildTextField(
                      controller: _stdsVulvoPerinealController,
                      label: 'STDs: Vulvo-perineal Condylomatosis',
                      hint: 'Enter 0 or 1',
                      validator: (value) => _validateBinary(
                        value,
                        'Vulvo-perineal condylomatosis',
                      ),
                      icon: Icons.medical_information,
                    ),
                    const SizedBox(height: 16),

                    // Field 5: STDs:HIV
                    _buildTextField(
                      controller: _stdsHivController,
                      label: 'STDs: HIV',
                      hint: 'Enter 0 or 1',
                      validator: (value) => _validateBinary(value, 'HIV'),
                      icon: Icons.medical_information,
                    ),
                    const SizedBox(height: 16),

                    // Field 6: STDs: Number of diagnosis
                    _buildTextField(
                      controller: _stdsNumDiagnosisController,
                      label: 'STDs: Number of Diagnosis',
                      hint: 'Enter 0-10',
                      validator: (value) =>
                          _validateRange(value, 'Number of diagnosis', 0, 10),
                      icon: Icons.numbers,
                      helperText: 'Value between 0 and 10',
                    ),
                    const SizedBox(height: 16),

                    // Field 7: Dx:Cancer
                    _buildTextField(
                      controller: _dxCancerController,
                      label: 'Dx: Cancer',
                      hint: 'Enter 0 or 1',
                      validator: (value) =>
                          _validateBinary(value, 'Cancer diagnosis'),
                      icon: Icons.local_hospital,
                    ),
                    const SizedBox(height: 16),

                    // Field 8: Dx:HPV
                    _buildTextField(
                      controller: _dxHpvController,
                      label: 'Dx: HPV',
                      hint: 'Enter 0 or 1',
                      validator: (value) =>
                          _validateBinary(value, 'HPV diagnosis'),
                      icon: Icons.local_hospital,
                    ),
                    const SizedBox(height: 16),

                    // Field 9: Dx
                    _buildTextField(
                      controller: _dxController,
                      label: 'Dx',
                      hint: 'Enter 0 or 1',
                      validator: (value) => _validateBinary(value, 'Diagnosis'),
                      icon: Icons.local_hospital,
                    ),
                    const SizedBox(height: 16),

                    // Field 10: Citology
                    _buildTextField(
                      controller: _citologyController,
                      label: 'Citology',
                      hint: 'Enter 0 or 1',
                      validator: (value) => _validateBinary(value, 'Citology'),
                      icon: Icons.science,
                    ),
                    const SizedBox(height: 32),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitForm,
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
