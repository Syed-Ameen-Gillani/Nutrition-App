import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrovite/core/utils/data.dart';
import 'package:nutrovite/core/utils/validators.dart';
import 'package:nutrovite/features/auth/view_models/bloc/auth_bloc.dart';
import 'package:nutrovite/features/auth/views/widgets/auth_button.dart';
import 'package:nutrovite/core/extensions/media_query_extensions.dart';
import 'package:nutrovite/features/home/view_models/form_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();

  String _selectedGender = 'Male';
  DateTime _selectedDate = DateTime.now();
  String _selectedProvince = 'Islamabad';

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format to yyyy-MM-dd
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final int age = _calculateAge(_selectedDate);

      // Dispatch the AuthRegisterEvent to the AuthBloc
      context.read<AuthBloc>().add(
            AuthRegisterEvent(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              age: age.toString(),
              gender: _selectedGender,
              dob: _dobController.text,
              city: _selectedProvince,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.08),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: context.tTheme.displaySmall!.copyWith(
                      color: context.cScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProfileField(
                    controller: _nameController,
                    label: 'Name',
                    validator: Validators.validateName,
                    icon: Icons.person_2_outlined,
                    enabled: true,
                  ),
                  // const SizedBox(height: 10),
                  ProfileField(
                    controller: _emailController,
                    label: 'Email',
                    validator: Validators.validateEmail,
                    icon: Icons.alternate_email_rounded,
                    enabled: true,
                  ),
                  // const SizedBox(height: 10),
                  ProfileField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: true,
                    icon: Icons.lock_outline_rounded,
                    validator: Validators.validatePassword,
                    enabled: true,
                  ),
                  // const SizedBox(height: 10),
                  CustomDropdown(
                    selectedValue: _selectedGender,
                    label: 'Gender',
                    icon: const Icon(Icons.family_restroom_outlined),
                    items: genders,
                    enabled: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _selectedGender = newValue);
                      }
                    },
                  ),
                  // const SizedBox(height: 10),
                  CustomDropdown(
                    selectedValue: _selectedProvince,
                    label: 'Select City',
                    icon: const Icon(Icons.location_city_outlined),
                    items: cities,
                    enabled: true,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _selectedProvince = newValue);
                      }
                    },
                  ),

                  // const SizedBox(height: 10),
                  ProfileField(
                    controller: _dobController,
                    enabled: true,
                    label: 'Date of Birth',
                    suffixIcon: IconButton(
                      onPressed: _selectDate,
                      icon: const Icon(Icons.calendar_month_rounded),
                    ),
                    icon: Icons.data_exploration,
                    validator: (String? value) {
                      if (value != null || value!.isNotEmpty) {
                        return null;
                      }
                      return 'Please select date of birth';
                    },
                  ),
                  const SizedBox(height: 30),

                  // BlocConsumer to handle AuthBloc state changes
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthAuthenticated) {
                        Navigator.pushNamed(
                          context,
                          '/otp',
                          arguments:
                              state.user.id, // Adjust as per your OTP flow
                        );
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
                          label: 'Sign Up',
                          onPressed: () => _signUp(context),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Already have an account?",
                            style: context.tTheme.bodySmall!.copyWith(
                              color: context.cScheme.onPrimaryContainer,
                            ),
                          ),
                          TextSpan(
                            text: " Sign In",
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
