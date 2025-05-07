import 'package:flutter/material.dart';
import 'register_step3_screen.dart';

class RegisterStep2Screen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final int age;

  const RegisterStep2Screen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.age,
  }) : super(key: key);

  @override
  _RegisterStep2ScreenState createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedGender = '';
  final _locationController = TextEditingController();
  final _schoolController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (_formKey.currentState!.validate() && _selectedGender.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterStep3Screen(
            firstName: widget.firstName,
            lastName: widget.lastName,
            age: widget.age,
            gender: _selectedGender,
            location: _locationController.text,
            school: _schoolController.text,
          ),
        ),
      );
    } else if (_selectedGender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner votre genre')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LinearProgressIndicator(value: 0.66),
                const SizedBox(height: 24),
                const Text(
                  'Étape 2/3: Informations démographiques',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Genre',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Masculin'),
                        value: 'Masculin',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Féminin'),
                        value: 'Féminin',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Lieu de résidence',
                    prefixIcon: const Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre lieu de résidence';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _schoolController,
                  decoration: InputDecoration(
                    labelText: 'École/Établissement',
                    prefixIcon: const Icon(Icons.school_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom de votre école';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Retour'),
                    ),
                    ElevatedButton(
                      onPressed: _goToNextStep,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Suivant'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}