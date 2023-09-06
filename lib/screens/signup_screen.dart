import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool acceptTerms = false;
  bool receiveUpdates = false;

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
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Se connecter'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Créer un compte',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Prénom*",
              controller: firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ce champ est requis";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Nom*",
              controller: lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ce champ est requis";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  birthDateController.text =
                  selectedDate.toLocal().toIso8601String().split("T")[0];
                }
              },
              child: AbsorbPointer(
                child: CustomTextField(
                  label: "Date de naissance*",
                  controller: birthDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ce champ est requis";
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Adresse e-mail*",
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ce champ est requis";
                }
                if (!value.contains("@")) {
                  return "Veuillez saisir une adresse e-mail valide.";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Mot de passe*",
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ce champ est requis";
                }
                if (value.length < 8) {
                  return "Le mot de passe est trop fiable.";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "8 caractères minimum, incluant au moins un chiffre et une lettre",
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: acceptTerms,
                  onChanged: (newValue) {
                    setState(() {
                      acceptTerms = newValue ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "Oui, j'accepte les Conditions Générales d'Utilisation et je confirme avoir pris connaissance de la Déclaration de Confidentialité",
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: receiveUpdates,
                  onChanged: (newValue) {
                    setState(() {
                      receiveUpdates = newValue ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "Recevoir les mises à jour",
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),


            const SizedBox(height: 16),
            CustomButton(
              label: "Créer un compte",
              backgroundColor: const Color(0xFFFFA149),
              textColor: Colors.white,
              onPressed: () async {
                BuildContext currentContext = context;  // حفظ القيمة الحالية لـ BuildContext

                if (!acceptTerms) {
                  // إظهار رسالة تنبيه إذا لم يوافق المستخدم على الشروط
                  ScaffoldMessenger.of(currentContext).showSnackBar(
                    const SnackBar(
                      content: Text('Veuillez acceptez les conditions générales d’utilisation'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  return;
                }

                UserCredential? user = await authService.registerUser(emailController.text, passwordController.text);
                if (user != null) {
                  print("User registered: ${user.user?.email}");
                  Navigator.pushReplacementNamed(currentContext, '/login');  // استخدام القيمة المحفوظة لـ BuildContext
                } else {
                  ScaffoldMessenger.of(currentContext).showSnackBar(
                    const SnackBar(
                      content: Text('Échec de la création du compte. Veuillez réessayer.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
            ),


          ],
        ),
      ),
    );
  }
}
