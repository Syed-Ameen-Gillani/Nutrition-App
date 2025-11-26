import 'package:flutter/material.dart';
import 'package:nutrovite/core/utils/app_colors.dart';
import 'package:nutrovite/features/auth/views/screens/login_screen.dart';
import 'package:nutrovite/features/auth/views/widgets/auth_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: NutroviteColor.home,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 10),
              const Text(
                'Welcome to Nutrovite',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: NutroviteColor.txt,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/pizza_logo.png',
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
              const Text(
                'Enjoy Your Food',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: NutroviteColor.txt,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomSubmitButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                label: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
