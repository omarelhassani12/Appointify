String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }

  bool emailValid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(value);

  if (!emailValid) {
    return 'Please enter a valid email';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }

  return null;
}
