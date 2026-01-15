class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(
      r"^[A-ZÀ-ÿ][A-Za-zÀ-ÿ' -]*([A-Za-zÀ-ÿ][A-Za-zÀ-ÿ' -]*)*$",
    );

    if (value == null || value.isEmpty) {
      return "The field can not be empty";
    }
    if (!condition.hasMatch(value.trim())) {
      return "Invalid name. Use only letters, spaces, hyphens and apostrophes";
    }
    if (value.trim().length < 2) {
      return "Name must be at least 2 characters long";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    if (value == null || value.isEmpty) {
      return "The field can not be empty";
    }
    if (!condition.hasMatch(value)) {
      return "Invalid e-mail format.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    );

    if (value == null || value.isEmpty) {
      return "The field can not be empty";
    }
    if (!condition.hasMatch(value)) {
      return "Password must contain:\n• At least 8 characters\n• One uppercase letter\n• One lowercase letter\n• One number\n• One special character (@\$!%*?&)";
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? choosedValue,
    String? confirmedValue,
  ) {
    if (confirmedValue == null || confirmedValue.isEmpty) {
      return "Please confirm your password";
    }
    if (choosedValue != confirmedValue) {
      return "Passwords do not match";
    }
    return null;
  }
}
