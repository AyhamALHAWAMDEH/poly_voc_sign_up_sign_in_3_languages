import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';  // Import your CustomButton widget

class AccountChoiceScreen extends StatelessWidget {
  const AccountChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Main title at the top
              const Text(
                'Magasin',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Second title
              const Text(
                'Mon Magasin, vos bons plans!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Description
              const Text(
                'Profitez encore plus de l\'application avec Mon Magasin! Shoppez malin grâce à votre liste de favoris, retrouvez tous vos tickets de caisse dématérialisés et tentez de gagner des cartes-cadeaux !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              // Create Account Button
              CustomButton(
                label: 'Créer un compte',
                backgroundColor: Color(0xFFFFA149),  // Orange
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
              ),
              const SizedBox(height: 20),
              // Login Button
              // Login Button
              CustomButton(
                label: 'Se connecter',
                backgroundColor: Colors.white,
                textColor: const Color(0xFFFFA149),  // Orange
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                buttonType: ButtonType.outlined,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
