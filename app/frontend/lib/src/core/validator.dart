String? requiredValidation(String? value, String detail) {
  if (value == null || value.isEmpty)
    return detail;
  else
    return null;
}

String? passwordValidation(String? value) {
  if (value == null || value.isEmpty) return null;
  if (value.length < 8) return 'Minimum lenght is 8 characters';
  return null;
}
