import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:poly_voc/services/auth_service.dart';
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final AuthService authService = AuthService();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF92E6F3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/accountChoice');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
            child: const Text('Créer un compte'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,  // This line centers the child widgets
            children: [
              // Main title
              const Text(
                'Se connecter',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              // Email input field
              CustomTextField(
                label: 'Adresse e-mail',
                controller: emailController,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Veuillez saisir une adresse e-mail valide.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Password input field
              CustomTextField(
                label: 'Mot de passe',
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mot de passe est requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Forgot Password
              TextButton(
                onPressed: () {
                  // Navigate to Forgot Password
                },
                child: const Text('Mot de passe oublié ?'),
              ),
              const SizedBox(height: 20),
              // Login button
              CustomButton(
                label: 'Se connecter',
                backgroundColor: const Color(0xFFFFA149),
                textColor: Colors.white,
                onPressed: () async {
                  // استخدام القيم المدخلة من قبل المستخدم هنا
                  UserCredential? user = await authService.loginUser(emailController.text, passwordController.text);
                  if (user != null) {
                    print("User logged in: ${user.user?.email}");
                    // يمكنك الانتقال إلى الشاشة الرئيسية هنا
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
