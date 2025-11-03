class Validator {
  Validator._();

  static String? validateName(String? value) {
    final condition = RegExp(r"^[A-Za-z]+(?: [A-Za-z]+)*$");

    if (value != null && value.isEmpty) {
      return "The field can not be empty";
    }
    if (value != null && condition.hasMatch(value)) {
      return "Invalid name.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final condition = RegExp(
      r"/^((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$",
    );

    if (value != null && value.isEmpty) {
      return "The field can not be empty";
    }
    if (value != null && condition.hasMatch(value)) {
      return "Invalid e-mail.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
    );

    if (value != null && value.isEmpty) {
      return "The field can not be empty";
    }
    if (value != null && condition.hasMatch(value)) {
      return "Invalid e-mail.";
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? choosedValue,
    String? confirmedValue,
  ) {
    if (choosedValue != confirmedValue) {
      return "Passwords do not macth";
    }
    return null;
  }
}
