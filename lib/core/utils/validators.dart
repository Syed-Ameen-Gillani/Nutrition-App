class Validators {
  // Validator for Name field
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  // Validator for Email field
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // Validator for Password field
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    
    // Minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // At least one special character
    final specialCharRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharRegExp.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    // At least one lowercase letter
    final lowercaseRegExp = RegExp(r'[a-z]');
    if (!lowercaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // At least one uppercase letter
    final uppercaseRegExp = RegExp(r'[A-Z]');
    if (!uppercaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // At least one digit
    final digitRegExp = RegExp(r'[0-9]');
    if (!digitRegExp.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    return null;
  }

  // Validator for Age field
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    return null;
  }

  // Validator for Gender Dropdown
  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }
}
