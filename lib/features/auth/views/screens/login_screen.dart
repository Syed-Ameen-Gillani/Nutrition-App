import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/core/utils/validators.dart';
import 'package:nutrovite/features/auth/view_models/bloc/auth_bloc.dart';
import 'package:nutrovite/features/auth/views/widgets/auth_button.dart';
import 'package:nutrovite/features/home/view_models/form_fields.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.08),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: context.tTheme.displaySmall!.copyWith(
                      color: context.cScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProfileField(
                    controller: _emailController,
                    label: 'Email',
                    validator: Validators.validateEmail,
                    icon: Icons.alternate_email_rounded,
                    enabled: true,
                  ),
                  const SizedBox(height: 15),
                  ProfileField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
                    validator: Validators.validatePassword,
                    icon: Icons.lock_outline_rounded,
                    enabled: true,
                  ),
                  const SizedBox(height: 30),

                  // BlocConsumer for handling AuthBloc state changes
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthAuthenticated) {
                        // Navigate to home screen on successful sign-in
                        Navigator.pushNamed(context, '/home');
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return CustomSubmitButton(
                          label: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthLoginEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                          onLongPressed: () {
                            _emailController.text = 'user@nutrovite.com';
                            _passwordController.text = '@User1234567890';
                          },
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 15),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Don't have an account?",
                            style: context.tTheme.bodySmall!.copyWith(
                              color: context.cScheme.onPrimaryContainer,
                            ),
                          ),
                          TextSpan(
                            text: " Create",
                            style: context.tTheme.bodySmall!.copyWith(
                              color: context.cScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
